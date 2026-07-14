import 'dart:async';

import 'package:dialcalink/core/database/drift/app_database.dart';
import 'package:dialcalink/core/database/drift/tables/call_logs_table.dart';
import 'package:dialcalink/core/identity/device_identity_service.dart';
import 'package:dialcalink/core/network/websocket/client/gateway_ws_client.dart';
import 'package:dialcalink/core/network/websocket/client/ws_connection_state.dart';
import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:dialcalink/core/notifications/notification_service.dart';
import 'package:dialcalink/core/platform/client/native/client_ui_bridge.dart';
import 'package:dialcalink/features/calls/domain/entities/call_log_entity.dart';
import 'package:dialcalink/features/calls/domain/usecases/apply_synced_call_usecase.dart';
import 'package:dialcalink/features/sms/domain/entities/sms_message_entity.dart';
import 'package:dialcalink/features/sms/domain/usecases/apply_synced_sms_usecase.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ClientConnectionService {
  ClientConnectionService({
    required this.database,
    required this.identityService,
    required this.applySmsUseCase,
    required this.applyCallUseCase,
    required this.notificationService,
    required this.uiBridge,
    Logger? logger,
  }) : _logger = logger ?? Logger();

  final AppDatabase database;
  final DeviceIdentityService identityService;
  final ApplySyncedSmsUseCase applySmsUseCase;
  final ApplySyncedCallUseCase applyCallUseCase;
  final NotificationService notificationService;
  final ClientUiBridge uiBridge;
  final Logger _logger;

  GatewayWsClient? _client;
  StreamSubscription<WsConnectionState>? _stateSub;
  StreamSubscription<WsIncomingEvent>? _eventSub;
  StreamSubscription<String>? _commandSub;
  StreamSubscription<SendSmsCommand>? _sendSmsSub;

  Future<void> start() async {
    _logger.i('ClientConnectionService: iniciando...');

    await notificationService.initialize(onNotificationTapped: (_) {});
    uiBridge.startListeningCommandsFromService();
    _commandSub = uiBridge.commands.listen(_handleCommand);
    _sendSmsSub = uiBridge.sendSmsCommands.listen(_handleSendSmsCommand);

    await _connectToGateway();

    _logger.i('ClientConnectionService: iniciado correctamente');
  }

  Future<void> stop() async {
    await _commandSub?.cancel();
    _commandSub = null;
    await _sendSmsSub?.cancel();
    _sendSmsSub = null;
    await _disconnect();
    _logger.i('ClientConnectionService: detenido');
  }

  Future<void> _connectToGateway() async {
    await uiBridge.emitConnectionState(ClientConnectionStateBridge.connecting);

    final identity = await identityService.readIdentity();
    if (identity == null) {
      _logger.w('ClientConnectionService: sin identidad local, abortando');
      await uiBridge.emitConnectionState(ClientConnectionStateBridge.error);
      return;
    }

    final linkedDevices = await database.devicesDao.watchLinkedDevices().first;
    final gateway = linkedDevices.firstOrNull;

    if (gateway == null) {
      _logger.w('ClientConnectionService: sin Gateway vinculado');
      await uiBridge.emitConnectionState(
        ClientConnectionStateBridge.disconnected,
      );
      return;
    }

    final ip = gateway.lastKnownIp;
    final port = gateway.lastKnownPort;

    if (ip == null || port == null) {
      _logger.w('ClientConnectionService: Gateway sin IP o puerto conocido');
      await uiBridge.emitConnectionState(ClientConnectionStateBridge.error);
      return;
    }

    _logger.i('ClientConnectionService: conectando a Gateway $ip:$port');

    _client?.disconnect();
    _client = GatewayWsClient.forSession(
      ip: ip,
      port: port,
      clientDeviceId: identity.id,
    );

    _stateSub?.cancel();
    _stateSub = _client!.connectionState.listen(_handleConnectionState);

    _eventSub?.cancel();
    _eventSub = _client!.incomingEvents.listen(_handleEvent);

    _client!.connect();
  }

  Future<void> _disconnect() async {
    await _stateSub?.cancel();
    _stateSub = null;
    await _eventSub?.cancel();
    _eventSub = null;
    _client?.disconnect();
    _client = null;
    await uiBridge.emitConnectionState(
      ClientConnectionStateBridge.disconnected,
    );
  }

  Future<void> _handleConnectionState(WsConnectionState state) async {
    _logger.i('ClientConnectionService: estado WS -> ${state.runtimeType}');

    final bridgeState = switch (state) {
      WsDisconnected() => ClientConnectionStateBridge.disconnected,
      WsConnecting() => ClientConnectionStateBridge.connecting,
      WsConnected() => ClientConnectionStateBridge.connected,
      WsReady() => ClientConnectionStateBridge.ready,
      WsReconnecting() => ClientConnectionStateBridge.reconnecting,
      WsHandshakeRejected() => ClientConnectionStateBridge.handshakeRejected,
      WsError() => ClientConnectionStateBridge.error,
    };

    String? gatewayName;
    if (state is WsReady) {
      final linked = await database.devicesDao.watchLinkedDevices().first;
      gatewayName = linked.firstOrNull?.deviceName;
      _logger.i('ClientConnectionService: conectado a Gateway "$gatewayName"');
    }

    await uiBridge.emitConnectionState(bridgeState, gatewayName: gatewayName);
  }

  Future<void> _handleEvent(WsIncomingEvent event) async {
    switch (event) {
      case WsSmsEvent(payload: final payload):
        await _applySms(payload);
      case WsCallIncomingEvent(payload: final payload):
        await _applyCallIncoming(payload);
      case WsCallEndedEvent(payload: final payload):
        await _applyCallEnded(payload);
      case WsSyncResponseEvent(payload: final payload):
        await _applySyncResponse(payload);
      case WsSmsSentEvent(payload: final payload):
        await _handleSmsSent(payload);
    }
  }

  Future<void> _applySms(WsSmsReceivedPayload payload) async {
    debugPrint('[DIALCA][CLIENT-SVC] recibido SMS de ${payload.phoneNumber}');

    final entity = SmsMessageEntity(
      id: payload.id,
      phoneNumber: payload.phoneNumber,
      content: payload.content,
      receivedAt: payload.receivedAt,
      sourceDeviceId: payload.sourceDeviceId,
      isRead: false,
      contactName: payload.contactName,
      direction: payload.direction,
    );

    final result = await applySmsUseCase.call(entity);
    result.when(
      ok: (_) {
        debugPrint('[DIALCA][CLIENT-SVC] SMS guardado: ${payload.id}');
        notificationService.showSmsNotification(
          smsId: payload.id,
          displayName: payload.contactName ?? payload.phoneNumber,
          content: payload.content,
          payload: payload.phoneNumber,
        );
        _client?.sendSyncAck(payload.id);
      },
      failure: (f) {
        _logger.e('ClientConnectionService: error guardando SMS', error: f);
      },
    );
  }

  Future<void> _applyCallIncoming(WsCallIncomingPayload payload) async {
    debugPrint(
      '[DIALCA][CLIENT-SVC] recibido llamada entrante de ${payload.phoneNumber}',
    );

    final entity = CallLogEntity(
      id: payload.id,
      phoneNumber: payload.phoneNumber,
      callType: CallType.incoming,
      sourceDeviceId: payload.sourceDeviceId,
      contactName: payload.contactName,
      startedAt: payload.startedAt,
      endedAt: null,
    );

    final result = await applyCallUseCase.call(entity);
    result.when(
      ok: (_) {
        debugPrint(
          '[DIALCA][CLIENT-SVC] llamada entrante guardada: ${payload.id}',
        );
        notificationService.showCallNotification(
          callId: payload.id,
          displayName: payload.contactName ?? payload.phoneNumber,
          phoneNumber: payload.phoneNumber,
        );
        _client?.sendSyncAck(payload.id);
      },
      failure: (f) {
        _logger.e(
          'ClientConnectionService: error guardando llamada entrante',
          error: f,
        );
      },
    );
  }

  Future<void> _applyCallEnded(WsCallEndedPayload payload) async {
    final entity = CallLogEntity(
      id: payload.id,
      phoneNumber: payload.phoneNumber,
      callType: payload.callType,
      sourceDeviceId: payload.sourceDeviceId,
      contactName: null,
      startedAt: null,
      endedAt: payload.endedAt,
    );
    final result = await applyCallUseCase.call(entity);
    result.when(
      ok: (_) => _client?.sendSyncAck(payload.id),
      failure: (f) => _logger.e(
        'ClientConnectionService: error cerrando llamada',
        error: f,
      ),
    );
  }

  Future<void> _applySyncResponse(WsSyncResponsePayload payload) async {
    _logger.i(
      'ClientConnectionService: sync response con '
      '${payload.events.length} evento(s)',
    );
    for (final event in payload.events) {
      if (event.sms != null) await _applySms(event.sms!);
      if (event.callIncoming != null) {
        await _applyCallIncoming(event.callIncoming!);
      }
      if (event.callEnded != null) await _applyCallEnded(event.callEnded!);
    }
  }

  Future<void> _handleCommand(String command) async {
    _logger.i('ClientConnectionService: comando recibido: $command');
    switch (command) {
      case 'reconnect_requested':
        _logger.i('ClientConnectionService: iniciando reconexión forzada');
        await _disconnect();
        _logger.i('ClientConnectionService: desconectado, ahora conectando...');
        await _connectToGateway();
      case 'disconnect_requested':
        _logger.i('ClientConnectionService: desconectando...');
        await _disconnect();
    }
  }

  Future<void> _handleSmsSent(WsSmsSentPayload payload) async {
    _logger.i(
      'ClientConnectionService: resultado envío SMS ${payload.id} -> '
      'success=${payload.success}',
    );
    await uiBridge.emitSmsSentResult(
      payload.id,
      payload.success,
      payload.errorReason,
    );
  }
  Future<void> _handleSendSmsCommand(SendSmsCommand cmd) async {
    _logger.i('ClientConnectionService: solicitando envío SMS a ${cmd.to}');
    _client?.sendSms(cmd.to, cmd.content);
  }
}
