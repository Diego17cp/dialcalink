import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:dialcalink/core/network/websocket/messages/ws_message.dart';
import 'package:dialcalink/core/network/websocket/messages/ws_message_type.dart';
import 'package:dialcalink/core/network/websocket/server/ws_client_session.dart';

enum GatewayWsServerStatus { stopped, starting, running, error }

sealed class GatewayWsServerStartResult {}

class GatewayWsServerStarted extends GatewayWsServerStartResult {}

class GatewayWsServerFailed extends GatewayWsServerStartResult {
  GatewayWsServerFailed(this.reason);
  final String reason;
}

class GatewayWsServer {
  GatewayWsServer({
    required this.port,
    required this.gatewayDeviceId,
    required this.gatewayName,
    required this.onHandshakeRequest,
    required this.onSyncRequested,
    required this.onSyncAckReceived,
    required this.onSendSmsRequested,
    this.onClientDisconnected,
    Duration pingInterval = const Duration(seconds: 20),
    Duration heartbeatTimeout = const Duration(seconds: 60),
    Logger? logger,
  }) : _pingInterval = pingInterval,
       _heartbeatTimeout = heartbeatTimeout,
       _logger = logger ?? Logger();

  final int port;
  final String gatewayDeviceId;
  final String gatewayName;
  final Duration _pingInterval;
  final Duration _heartbeatTimeout;
  final Logger _logger;

  final Future<bool> Function(String? pairingToken, String clientDeviceId)
  onHandshakeRequest;
  final Future<List<WsSyncEventDto>> Function() onSyncRequested;
  final Future<void> Function(String eventId) onSyncAckReceived;
  final void Function()? onClientDisconnected;
  final Future<WsSmsSentPayload> Function(String to, String content) onSendSmsRequested;

  HttpServer? _httpServer;
  WsClientSession? _connectedClient;
  Timer? _heartbeatTimer;

  GatewayWsServerStatus _status = GatewayWsServerStatus.stopped;
  GatewayWsServerStatus get status => _status;

  bool get hasConnectedClient => _connectedClient?.isHandshakeComplete ?? false;

  Future<GatewayWsServerStartResult> start() async {
    if (_status == GatewayWsServerStatus.running) {
      return GatewayWsServerStarted();
    }
    _status = GatewayWsServerStatus.starting;

    try {
      _httpServer = await HttpServer.bind(InternetAddress.anyIPv4, port);
      _logger.i('SERVER-LOG: Escuchando en ${_httpServer!.address.address}:${_httpServer!.port}');
      _httpServer!
          .transform(WebSocketTransformer())
          .listen(
            _onNewConnection,
            onError: (e) {
              _logger.e('GatewayWsServer: Error in the server', error: e);
              _status = GatewayWsServerStatus.error;
            },
          );
      _startHeartbeat();
      _status = GatewayWsServerStatus.running;
      _logger.i('GatewayWsServer started on port $port');
      return GatewayWsServerStarted();
    } catch (e) {
      _status = GatewayWsServerStatus.error;
      _logger.e('GatewayWsServer: Failed to start server', error: e);
      return GatewayWsServerFailed(e.toString());
    }
  }

  Future<void> stop() async {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    await _connectedClient?.close(1001, 'Server shutting down');
    _connectedClient = null;
    await _httpServer?.close(force: true);
    _httpServer = null;
    _status = GatewayWsServerStatus.stopped;
    _logger.i('GatewayWsServer stopped');
  }

  void _onNewConnection(WebSocket socket) {
    if (_connectedClient != null) {
      _logger.w(
        'GatewayWsServer: Rejecting new connection - already have a connected client',
      );
      socket.close(4003, 'Only one client allowed');
      return;
    }
    final session = WsClientSession(clientDeviceId: 'pending', socket: socket);
    _connectedClient = session;
    _logger.i('GatewayWsServer: New client connected, awaiting handshake');

    session.messages.listen(
      (raw) => _onMessageReceived(session, raw),
      onDone: () => _onClientDisconnected(session),
      onError: (e) {
        _logger.e('GatewayWsServer: Error in client session', error: e);
        _onClientDisconnected(session);
      },
      cancelOnError: true,
    );
  }

  void _onClientDisconnected(WsClientSession session) {
    if (_connectedClient == session) {
      _connectedClient = null;
      _logger.i('GatewayWsServer: Client disconnected');
      onClientDisconnected?.call();
    }
  }

  Future<void> _onMessageReceived(WsClientSession session, String raw) async {
    final message = WsMessage.fromJsonString(raw);

    switch (message.type) {
      case WsMessageType.handshake:
        await _handleHandshake(session, message.payload);
      case WsMessageType.syncRequest:
        await _handleSyncRequest(session);
      case WsMessageType.syncAck:
        await _handleSyncAck(session, message.payload);
      case WsMessageType.pong:
        session.markPongReceived();
        _logger.d('GatewayWsServer: Received pong from client');
      case WsMessageType.sendSms:
        await _handleSendSms(session, message.payload);
      default:
        _logger.w(
          'GatewayWsServer: Received unknown message type: ${message.type}',
        );
    }
  }

  Future<void> _handleHandshake(
    WsClientSession session,
    WsPayload payload,
  ) async {
    if (payload is! WsHandshakePayload) {
      session.send(
        const WsMessage(
          type: WsMessageType.handshakeError,
          payload: WsHandshakeErrorPayload(reason: 'Invalid handshake payload'),
        ).toJsonString(),
      );
      return;
    }
    final isValid = await onHandshakeRequest(
      payload.pairingToken,
      payload.clientDeviceId,
    );

    if (!isValid) {
      final reason = payload.isReconnection
          ? 'Reconnection attempt rejected - invalid client device ID'
          : 'Invalid pairing token';
      _logger.w(
        'GatewayWsServer: Handshake failed for device ${payload.clientDeviceId}: $reason',
      );
      session.send(
        const WsMessage(
          type: WsMessageType.handshakeError,
          payload: WsHandshakeErrorPayload(reason: 'Invalid pairing token'),
        ).toJsonString(),
      );
      await session.close(4003, 'Invalid token');
      _connectedClient = null;
      return;
    }

    session.markHandshakeComplete();
    session.send(WsMessage(
      type: WsMessageType.handshakeOk,
      payload: WsHandshakeOkPayload(
        gatewayDeviceId: gatewayDeviceId,
        gatewayName: gatewayName,
      ),
    ).toJsonString());
    _logger.i(
      'GatewayWsServer: Handshake successful for device ${payload.clientDeviceId}',
    );
  }

  Future<void> _handleSyncRequest(WsClientSession session) async {
    if (!session.isHandshakeComplete) {
      _logger.w('GatewayWsServer: Attempt to sync before handshake completion');
      return;
    }
    final events = await onSyncRequested();
    session.send(
      WsMessage(
        type: WsMessageType.syncResponse,
        payload: WsSyncResponsePayload(events: events),
      ).toJsonString(),
    );
  }

  Future<void> _handleSyncAck(
    WsClientSession session,
    WsPayload payload,
  ) async {
    if (!session.isHandshakeComplete) return;
    if (payload is! WsSyncAckPayload) return;
    await onSyncAckReceived(payload.eventId);
  }

  Future<void> _handleSendSms(
    WsClientSession session,
    WsPayload payload
  ) async {
    if (!session.isHandshakeComplete) return;
    if (payload is! WsSendSmsPayload) return;
    final result = await onSendSmsRequested(payload.to, payload.content);
    session.send(
      WsMessage(type: WsMessageType.smsSent, payload: result).toJsonString()
    );
  }

  void broadcast(WsMessage message) {
    final client = _connectedClient;
    if (client == null || !client.isHandshakeComplete) return;
    client.send(message.toJsonString());
  }

  void broadcastSmsReceived(WsSmsReceivedPayload payload) {
    broadcast(WsMessage(type: WsMessageType.smsReceived, payload: payload));
  }

  void broadcastCallIncoming(WsCallIncomingPayload payload) {
    broadcast(WsMessage(type: WsMessageType.callIncoming, payload: payload));
  }

  void broadcastCallEnded(WsCallEndedPayload payload) {
    broadcast(WsMessage(type: WsMessageType.callEnded, payload: payload));
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_pingInterval, (_) {
      final client = _connectedClient;
      if (client == null) return;
      if (client.isHandshakeComplete && client.isTimedOut(_heartbeatTimeout)) {
        _logger.w(
          'GatewayWsServer: Client timed out due to missed heartbeats, disconnecting',
        );
        client.close(1001, 'Heartbeat timeout');
        _connectedClient = null;
        onClientDisconnected?.call();
        return;
      }
      if (client.isHandshakeComplete) {
        client.send(
          const WsMessage(
            type: WsMessageType.ping,
            payload: WsPingPayload(),
          ).toJsonString(),
        );
        _logger.d('GatewayWsServer: Sent ping to client');
      }
    });
  }
}
