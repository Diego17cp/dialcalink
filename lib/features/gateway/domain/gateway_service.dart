import 'dart:async';

import 'package:dialcalink/core/database/drift/tables/sms_messages_table.dart';
import 'package:dialcalink/features/sms/domain/usecases/send_sms_usecase.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:dialcalink/core/database/drift/app_database.dart';
import 'package:dialcalink/core/database/drift/tables/call_logs_table.dart';
import 'package:dialcalink/core/database/drift/tables/devices_table.dart';
import 'package:dialcalink/core/database/drift/tables/sync_events_table.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/core/identity/device_identity_service.dart';
import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:dialcalink/core/network/websocket/server/gateway_ws_server.dart';
import 'package:dialcalink/core/platform/contacts/contact_resolver_service.dart';
import 'package:dialcalink/core/platform/gateway/native/gateway_native_bridge.dart';
import 'package:dialcalink/core/platform/gateway/native/gateway_native_event.dart';
import 'package:dialcalink/core/platform/gateway/native/gateway_ui_bridge.dart';
import 'package:dialcalink/features/calls/domain/repositories/call_repository.dart';
import 'package:dialcalink/features/calls/domain/usecases/end_call_usecase.dart';
import 'package:dialcalink/features/calls/domain/usecases/register_incoming_call_usecase.dart';
import 'package:dialcalink/features/sms/domain/repositories/sms_repository.dart';
import 'package:dialcalink/features/sms/domain/usecases/receive_sms_usecase.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';
import 'package:dialcalink/features/sync/domain/repositories/sync_repository.dart';
import 'package:dialcalink/features/sync/domain/usecases/get_pending_sync_events_usecase.dart';

class GatewayService {
  GatewayService({
    required this.nativeBridge,
    required this.database,
    required this.identityService,
    required this.contactResolverService,
    required this.receiveSmsUseCase,
    required this.registerIncomingCallUseCase,
    required this.endCallUseCase,
    required this.getPendingSyncEventsUseCase,
    required this.smsRepository,
    required this.callRepository,
    required this.syncRepository,
    required this.uiBridge,
    required this.sendSmsUseCase,
    Logger? logger,
  }) : _logger = logger ?? Logger();

  final GatewayNativeBridge nativeBridge;
  final AppDatabase database;
  final DeviceIdentityService identityService;
  final ContactResolverService contactResolverService;

  final ReceiveSmsUseCase receiveSmsUseCase;
  final RegisterIncomingCallUseCase registerIncomingCallUseCase;
  final EndCallUseCase endCallUseCase;
  final GetPendingSyncEventsUseCase getPendingSyncEventsUseCase;
  final SendSmsUseCase sendSmsUseCase;

  final SmsRepository smsRepository;
  final CallRepository callRepository;
  final SyncRepository syncRepository;

  final Logger _logger;

  final GatewayUiBridge uiBridge;

  GatewayWsServer? _wsServer;
  StreamSubscription<GatewayNativeEvent>? _nativeEventSubscription;

  String? _activePairingToken;
  String? _localDeviceId;

  String? _lastRingingPhoneNumber;

  String? _connectedClientDeviceId;

  final _connectionStateController =
      StreamController<GatewayClientConnectionInfo>.broadcast();

  Stream<GatewayClientConnectionInfo> get connectionStateStream =>
      _connectionStateController.stream;

  String? get connectedClientDeviceId => _connectedClientDeviceId;

  static const int _port = 8888;

  Future<void> start() async {
    final identity = await identityService.readIdentity();
    if (identity == null) {
      _logger.e(
        'GatewayService: No device identity found, cannot start service',
      );
      return;
    }
    _localDeviceId = identity.id;
    _wsServer = GatewayWsServer(
      port: _port,
      gatewayDeviceId: identity.id,
      gatewayName: identity.name,
      onHandshakeRequest: _handleHandshakeRequest,
      onSyncRequested: _handleSyncRequested,
      onSyncAckReceived: _handleSyncAck,
      onClientDisconnected: _handleClientDisconnected,
      onSendSmsRequested: _handleSendSmsRequest,
    );
    final startResult = await _wsServer!.start();
    if (startResult is GatewayWsServerFailed) {
      _logger.e(
        'GatewayService: Failed to start WebSocket server: ${startResult.reason}',
      );
      return;
    }
    nativeBridge.startListening();
    _nativeEventSubscription = nativeBridge.events.listen(
      _handleNativeEvent,
      onError: (Object error) {
        _logger.e('GatewayService: Error receiving native event', error: error);
      },
    );
    final now = DateTime.now();
    await identityService.writeServiceStartedAt(now);
    uiBridge.startListeningConnectionUpdates();
    uiBridge.pairingTokenUpdates.listen((token) {
      debugPrint(
        '[DIALCA][BACK] Token recibido via stream: "$token" isEmpty: ${token.isEmpty}',
      );
      if (token.isNotEmpty) {
        setActivePairingToken(token);
      }
    });
    _logger.i(
      '[BACK-ENGINE] Servicio iniciado exitosamente y escuchando bridge.',
    );
    _logger.i('WebSocket server started on port $_port');
  }

  Future<void> stop() async {
    await _nativeEventSubscription?.cancel();
    _nativeEventSubscription = null;
    nativeBridge.stopListening();
    await _wsServer?.stop();
    _wsServer = null;
    _connectedClientDeviceId = null;
    await identityService.clearServiceStartedAt();
    _logger.i('GatewayService: Service stopped');
  }

  void setActivePairingToken(String token) {
    _activePairingToken = token;
  }

  Future<void> _handleNativeEvent(GatewayNativeEvent event) async {
    final sourceDeviceId = _localDeviceId;
    if (sourceDeviceId == null) return;

    switch (event) {
      case GatewayNativeSmsReceived():
        await _onSmsReceived(event, sourceDeviceId);
      case GatewayNativeCallIncoming():
        await _onCallIncoming(event, sourceDeviceId);
      case GatewayNativeCallEnded():
        await _onCallEnded(event, sourceDeviceId);
      case GatewayNativeCallOutgoing():
        await _onCallOutgoing(event, sourceDeviceId);
    }
  }

  Future<void> _onSmsReceived(
    GatewayNativeSmsReceived event,
    String sourceDeviceId,
  ) async {
    debugPrint('[DIALCA][BACK] SMS recibido de: ${event.phoneNumber}');
    debugPrint(
      '[DIALCA][BACK] Contenido: ${event.content.length > 30 ? event.content.substring(0, 30) : event.content}',
    );
    final contactName = await contactResolverService.resolveContactName(
      event.phoneNumber,
    );
    final result = await receiveSmsUseCase.call(
      phoneNumber: event.phoneNumber,
      content: event.content,
      sourceDeviceId: sourceDeviceId,
      contactName: contactName,
      receivedAt: event.receivedAt,
    );

    result.when(
      ok: (message) {
        debugPrint('[DIALCA][BACK] SMS guardado en DB con id: ${message.id}');
        debugPrint('[DIALCA][BACK] Emitiendo por WebSocket...');
        _wsServer?.broadcastSmsReceived(
          WsSmsReceivedPayload(
            id: message.id,
            phoneNumber: event.phoneNumber,
            content: event.content,
            receivedAt: event.receivedAt,
            sourceDeviceId: sourceDeviceId,
            contactName: contactName,
            direction: SmsDirection.incoming,
          ),
        );
        debugPrint('[DIALCA][BACK] SMS emitido por WebSocket');
      },
      failure: (failure) {
        _logger.e(
          'GatewayService: Error processing incoming SMS',
          error: failure,
        );
        debugPrint('[DIALCA][BACK] ERROR guardando SMS: ${failure.message}');
      },
    );
  }

  Future<WsSmsSentPayload> _handleSendSmsRequest(
    String to,
    String content,
  ) async {
    final result = await sendSmsUseCase.call(
      to: to,
      content: content,
      sourceDeviceId: _localDeviceId!,
    );
    return result.when(
      ok: (msg) {
        _wsServer?.broadcastSmsReceived(
          WsSmsReceivedPayload(
            id: msg.id,
            phoneNumber: to,
            content: content,
            receivedAt: msg.receivedAt,
            sourceDeviceId: _localDeviceId!,
            direction: SmsDirection.outgoing,
          ),
        );
        return WsSmsSentPayload(id: msg.id, to: to, success: true);
      },
      failure: (f) => WsSmsSentPayload(
        id: '',
        to: to,
        success: false,
        errorReason: f.message,
      ),
    );
  }

  Future<void> _onCallIncoming(
    GatewayNativeCallIncoming event,
    String sourceDeviceId,
  ) async {
    debugPrint('[DIALCA][BACK] Llamada entrante de: ${event.phoneNumber}');
    _lastRingingPhoneNumber = event.phoneNumber;

    final contactName = await contactResolverService.resolveContactName(
      event.phoneNumber,
    );

    final result = await registerIncomingCallUseCase.call(
      phoneNumber: event.phoneNumber,
      callType: CallType.incoming,
      sourceDeviceId: sourceDeviceId,
      contactName: contactName,
      startedAt: event.startedAt,
    );
    result.when(
      ok: (call) {
        debugPrint('[DIALCA][BACK] Llamada guardada en DB con id: ${call.id}');
        _wsServer?.broadcastCallIncoming(
          WsCallIncomingPayload(
            id: call.id,
            phoneNumber: event.phoneNumber,
            startedAt: event.startedAt,
            sourceDeviceId: sourceDeviceId,
            contactName: contactName,
            callType: CallType.incoming,
          ),
        );
        debugPrint('[DIALCA][BACK] Llamada emitida por WebSocket');
      },
      failure: (failure) {
        debugPrint(
          '[DIALCA][BACK] ERROR guardando llamada: ${failure.message}',
        );
        _logger.e(
          'GatewayService: Error processing incoming call',
          error: failure,
        );
      },
    );
  }

  Future<void> _onCallOutgoing(
    GatewayNativeCallOutgoing event,
    String sourceDeviceId,
  ) async {
    debugPrint('[DIALCA][BACK] Llamada saliente a: ${event.phoneNumber}');
    _lastRingingPhoneNumber = event.phoneNumber;

    final result = await registerIncomingCallUseCase.call(
      phoneNumber: event.phoneNumber,
      callType: CallType.outgoing,
      sourceDeviceId: sourceDeviceId,
      contactName: null,
      startedAt: event.startedAt,
    );

    result.when(
      ok: (callLog) {
        _wsServer?.broadcastCallIncoming(
          WsCallIncomingPayload(
            id: callLog.id,
            phoneNumber: event.phoneNumber,
            startedAt: event.startedAt,
            sourceDeviceId: sourceDeviceId,
            callType: CallType.outgoing,
            contactName: null,
          ),
        );
      },
      failure: (f) => debugPrint(
        '[DIALCA][BACK] ERROR guardando llamada saliente: ${f.message}',
      ),
    );
  }

  Future<void> _onCallEnded(
    GatewayNativeCallEnded event,
    String sourceDeviceId,
  ) async {
    final phoneNumber = _lastRingingPhoneNumber;
    if (event.callType == 'missed' && phoneNumber != null) {
      debugPrint('[DIALCA][BACK] Llamada perdida de: $phoneNumber');
      final result = await endCallUseCase.call(
        phoneNumber: phoneNumber,
        sourceDeviceId: sourceDeviceId,
        endedAt: event.endedAt,
      );
      result.when(
        ok: (callLog) async {
          await callRepository.upsertCall(
            callLog.copyWith(callType: CallType.missed),
          );
          _wsServer?.broadcastCallEnded(
            WsCallEndedPayload(
              id: callLog.id,
              phoneNumber: phoneNumber,
              endedAt: event.endedAt,
              sourceDeviceId: sourceDeviceId,
              callType: CallType.missed,
            ),
          );
        },
        failure: (f) => debugPrint(
          '[DIALCA][BACK] ERROR guardando llamada perdida: ${f.message}',
        ),
      );
      _lastRingingPhoneNumber = null;
      return;
    }
    if (phoneNumber == null) {
      debugPrint('[DIALCA][BACK] call_ended sin numero asociado, descartado');
      return;
    }
    _lastRingingPhoneNumber = null;
    final result = await endCallUseCase.call(
      phoneNumber: phoneNumber,
      sourceDeviceId: sourceDeviceId,
      endedAt: event.endedAt,
    );
    result.when(
      ok: (call) {
        _wsServer?.broadcastCallEnded(
          WsCallEndedPayload(
            id: call.id,
            phoneNumber: phoneNumber,
            endedAt: event.endedAt,
            sourceDeviceId: sourceDeviceId,
            callType: event.callType == 'missed'
                ? CallType.missed
                : CallType.incoming,
          ),
        );
      },
      failure: (f) => debugPrint('[DIALCA][BACK] ERROR: ${f.message}'),
    );
  }

  Future<bool> _handleHandshakeRequest(
    String? pairingToken,
    String clientDeviceId,
  ) async {
    debugPrint('[DIALCA][BACK] Token recibido: "$pairingToken"');
    debugPrint('[DIALCA][BACK] Token activo: "$_activePairingToken"');
    if (pairingToken != null) {
      final isValid = pairingToken == _activePairingToken;
      _logger.i('[BACK-ENGINE] Es pairing nuevo. Valido: $isValid');
      if (isValid) {
        _activePairingToken = null;
        await database.devicesDao.upsertDevice(
          DevicesCompanion(
            id: Value(clientDeviceId),
            deviceName: const Value('Cliente vinculado'),
            role: const Value(DeviceRole.client),
            pairingStatus: const Value(DevicePairingStatus.linked),
            createdAt: Value(DateTime.now()),
            lastSeenAt: Value(DateTime.now()),
          ),
        );
        _onClientConnected(clientDeviceId);
      }
      return isValid;
    }

    final device = await database.devicesDao.findById(clientDeviceId);
    final isLinked = device != null && device.pairingStatus.name == 'linked';
    _logger.i(
      '[BACK-ENGINE] Es reconexion. clientDeviceId: "$clientDeviceId" | '
      'Vinculado: $isLinked',
    );
    if (isLinked) {
      _onClientConnected(clientDeviceId);
    }
    return isLinked;
  }

  void _onClientConnected(String clientDeviceId) {
    _connectedClientDeviceId = clientDeviceId;
    _connectionStateController.add(
      GatewayClientConnectionInfo(
        isConnected: true,
        clientDeviceId: clientDeviceId,
      ),
    );
    uiBridge.sendConnectionUpdate(
      isConnected: true,
      clientDeviceId: clientDeviceId,
    );
  }

  void _handleClientDisconnected() {
    _connectedClientDeviceId = null;
    _connectionStateController.add(
      const GatewayClientConnectionInfo(
        isConnected: false,
        clientDeviceId: null,
      ),
    );
    uiBridge.sendConnectionUpdate(isConnected: false);
  }

  void dispose() {
    _connectionStateController.close();
  }

  Future<List<WsSyncEventDto>> _handleSyncRequested() async {
    final result = await getPendingSyncEventsUseCase.call();
    return result.when(
      ok: (List<SyncEventEntity> events) async {
        final dtos = <WsSyncEventDto>[];
        for (final syncEvent in events) {
          final dto = await _toSyncEventDto(syncEvent);
          if (dto != null) dtos.add(dto);
        }
        return dtos;
      },
      failure: (_) => <WsSyncEventDto>[],
    );
  }

  Future<WsSyncEventDto?> _toSyncEventDto(dynamic syncEvent) async {
    final entityType = syncEvent.entityType as SyncEntityType;
    final entityId = syncEvent.entityId as String;
    final eventId = syncEvent.id as String;

    if (entityType == SyncEntityType.smsMessage) {
      final result = await smsRepository.findById(entityId);
      final sms = result.valueOrNull;
      if (sms == null) return null;
      return WsSyncEventDto(
        eventId: eventId,
        type: 'sms_received',
        sms: WsSmsReceivedPayload(
          id: sms.id,
          phoneNumber: sms.phoneNumber,
          content: sms.content,
          receivedAt: sms.receivedAt,
          sourceDeviceId: sms.sourceDeviceId,
          contactName: sms.contactName,
          direction: SmsDirection.outgoing,
        ),
      );
    }
    final result = await callRepository.findById(entityId) as Result<dynamic>;
    final call = result.valueOrNull;
    if (call == null) return null;

    final isFinished = call.endedAt != null;
    final String eventType;
    if (isFinished) {
      eventType = 'call_ended';
    } else {
      eventType = call.callType == CallType.outgoing
          ? 'call_outgoing'
          : 'call_incoming';
    }
    if (isFinished) {
      return WsSyncEventDto(
        eventId: eventId,
        type: 'call_ended',
        callEnded: WsCallEndedPayload(
          id: call.id as String,
          endedAt: call.endedAt as DateTime,
          sourceDeviceId: call.sourceDeviceId as String,
          phoneNumber: call.phoneNumber as String,
          callType: call.callType as CallType,
        ),
      );
    }
    return WsSyncEventDto(
      eventId: eventId,
      type: eventType,
      callIncoming: WsCallIncomingPayload(
        id: call.id as String,
        phoneNumber: call.phoneNumber as String,
        startedAt: call.startedAt as DateTime,
        sourceDeviceId: call.sourceDeviceId as String,
        contactName: call.contactName as String?,
        callType: call.callType as CallType,
      ),
    );
  }

  Future<void> _handleSyncAck(String eventId) async {
    await syncRepository.markAsSynced(eventId);
  }
}

class GatewayClientConnectionInfo {
  const GatewayClientConnectionInfo({
    required this.isConnected,
    required this.clientDeviceId,
  });

  final bool isConnected;
  final String? clientDeviceId;
}
