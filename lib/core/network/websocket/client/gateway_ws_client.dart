import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:notidialca/core/network/websocket/client/ws_backoff_calculator.dart';
import 'package:notidialca/core/network/websocket/client/ws_connection_state.dart';
import 'package:notidialca/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:notidialca/core/network/websocket/messages/ws_message.dart';
import 'package:notidialca/core/network/websocket/messages/ws_message_type.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

sealed class WsIncomingEvent {
  const WsIncomingEvent();
}

class WsSmsEvent extends WsIncomingEvent {
  const WsSmsEvent(this.payload);
  final WsSmsReceivedPayload payload;
}

class WsCallIncomingEvent extends WsIncomingEvent {
  const WsCallIncomingEvent(this.payload);
  final WsCallIncomingPayload payload;
}

class WsCallEndedEvent extends WsIncomingEvent {
  const WsCallEndedEvent(this.payload);
  final WsCallEndedPayload payload;
}

class WsSyncResponseEvent extends WsIncomingEvent {
  const WsSyncResponseEvent(this.payload);
  final WsSyncResponsePayload payload;
}

class GatewayWsClient {
  GatewayWsClient.forPairing({
    required this.ip,
    required this.port,
    required String pairingToken,
    required this.clientDeviceId,
    WsBackoffCalculator? backoff,
    Logger? logger,
  })  : pairingToken = pairingToken,
        _backoff = backoff ?? const WsBackoffCalculator(),
        _logger = logger ?? Logger();
  GatewayWsClient.forSession({
    required this.ip,
    required this.port,
    required this.clientDeviceId,
    WsBackoffCalculator? backoff,
    Logger? logger,
  })  : pairingToken = null,
        _backoff = backoff ?? const WsBackoffCalculator(),
        _logger = logger ?? Logger();
  final String ip;
  final int port;
  final String? pairingToken;
  final String clientDeviceId;

  final WsBackoffCalculator _backoff;
  final Logger _logger;

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _reconnectTimer;

  bool _isDisposed = false;
  int _attempt = 0;

  final _stateController = StreamController<WsConnectionState>.broadcast();
  final _eventController = StreamController<WsIncomingEvent>.broadcast();

  WsConnectionState _state = const WsDisconnected();
  WsConnectionState get currentState => _state;

  Stream<WsConnectionState> get connectionState => _stateController.stream;

  Stream<WsIncomingEvent> get incomingEvents => _eventController.stream;

  String get _uri => 'ws://$ip:$port';

  void connect() {
    if (_isDisposed) return;
    _attempt = 0;
    _attemptConnect();
  }

  Future<void> disconnect() async {
    _isDisposed = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await _subscription?.cancel();
    _subscription = null;
    await _channel?.sink.close(1000, 'Manual disconnect');
    _channel = null;
    _setState(const WsDisconnected());
    await _stateController.close();
    await _eventController.close();
  }

  void _attemptConnect() async {
    if (_isDisposed) return;
    _attempt++;
    _setState(WsConnecting(attempt: _attempt));
    _logger.i(
      'GatewayWsClient: Attempting to connect to $_uri (attempt $_attempt)',
    );

    try {
      final socket = await WebSocket.connect(_uri).timeout(const Duration(seconds: 5));
      _channel = IOWebSocketChannel(socket);
      _subscription = _channel!.stream.listen(
        _onMessage,
        onDone: _onDisconnected,
        onError: (error) => _onError(error),
        cancelOnError: false,
      );
      _sendHandshake();
      _setState(const WsConnected());
    } catch (e) {
      _logger.e('GatewayWsClient: Connection attempt failed', error: e);
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_isDisposed) return;
    final delay = _backoff.delayFor(_attempt);
    _logger.i(
      'GatewayWsClient: Scheduling reconnect in ${delay.inSeconds} seconds (attempt ${_attempt + 1})',
    );
    _setState(WsReconnecting(attempt: _attempt, nextRetryIn: delay));
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, _attemptConnect);
  }

  void _onDisconnected() {
    if (_isDisposed || (_reconnectTimer?.isActive ?? false)) return;
    _logger.w('GatewayWsClient: Disconnected from server');
    _channel = null;
    _subscription = null;
    _scheduleReconnect();
  }

  void _onError(Object error) {
    _logger.e('GatewayWsClient: Connection error', error: error);
    if (_isDisposed || (_reconnectTimer?.isActive ?? false)) return;    
    _channel = null;
    _scheduleReconnect();
  }

  void _onMessage(dynamic raw) {
    if (raw is! String) return;
    final message = WsMessage.fromJsonString(raw);

    switch (message.type) {
      case WsMessageType.handshakeOk:
        _handleHandshakeOk();
      case WsMessageType.handshakeError:
        _handleHandshakeError(message.payload);
      case WsMessageType.ping:
        _sendPong();
      case WsMessageType.smsReceived:
        if (message.payload is WsSmsReceivedPayload) {
          _eventController.add(
            WsSmsEvent(message.payload as WsSmsReceivedPayload),
          );
        }
      case WsMessageType.callIncoming:
        if (message.payload is WsCallIncomingPayload) {
          _eventController.add(
            WsCallIncomingEvent(message.payload as WsCallIncomingPayload),
          );
        }
      case WsMessageType.callEnded:
        if (message.payload is WsCallEndedPayload) {
          _eventController.add(
            WsCallEndedEvent(message.payload as WsCallEndedPayload),
          );
        }
      case WsMessageType.syncResponse:
        if (message.payload is WsSyncResponsePayload) {
          _eventController.add(
            WsSyncResponseEvent(message.payload as WsSyncResponsePayload),
          );
        }
      default:
        _logger.d(
          'GatewayWsClient: Received unhandled message type: ${message.type}',
        );
    }
  }

  void _handleHandshakeOk() {
    _attempt = 0;
    _setState(const WsReady());
    _logger.i('GatewayWsClient: Handshake successful, connection is ready');
    _sendSyncRequest();
  }

  void _handleHandshakeError(WsPayload payload) {
    final reason = payload is WsHandshakeErrorPayload
        ? payload.reason
        : 'Handshake rejected by server';
    _logger.w('GatewayWsClient: Handshake failed: $reason');
    _setState(WsHandshakeRejected(reason: reason));
    _channel?.sink.close(4003, reason);
    _channel = null;
  }

  void _send(WsMessage message) {
    _channel?.sink.add(message.toJsonString());
  }

  void _sendHandshake() async {
    if (pairingToken != null) {
      await Future.delayed(const Duration(milliseconds: 800));
    }
    _send(
      WsMessage(
        type: WsMessageType.handshake,
        payload: WsHandshakePayload(
          pairingToken: pairingToken,
          clientDeviceId: clientDeviceId,
        ),
      ),
    );
    debugPrint('[DIALCA][CLIENT] Enviando token: "$pairingToken" at ${DateTime.now()}');
  }

  void _sendPong() {
    _send(const WsMessage(type: WsMessageType.pong, payload: WsPongPayload()));
    _logger.d('GatewayWsClient: Sent pong in response to ping');
  }

  void _sendSyncRequest() {
    _send(
      const WsMessage(
        type: WsMessageType.syncRequest,
        payload: WsSyncRequestPayload(),
      ),
    );
    _logger.d('GatewayWsClient: Sent sync request to server');
  }

  void sendSyncAck(String eventId) {
    _send(
      WsMessage(
        type: WsMessageType.syncAck,
        payload: WsSyncAckPayload(eventId: eventId),
      ),
    );
  }

  void _setState(WsConnectionState state) {
    _state = state;
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }
}
