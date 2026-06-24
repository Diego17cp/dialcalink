import 'dart:async';

import 'package:logger/logger.dart';
import 'package:notidialca/core/database/drift/app_database.dart';
import 'package:notidialca/core/database/drift/tables/call_logs_table.dart';
import 'package:notidialca/core/database/drift/tables/sync_events_table.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/core/identity/device_identity_service.dart';
import 'package:notidialca/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:notidialca/core/network/websocket/server/gateway_ws_server.dart';
import 'package:notidialca/core/platform/contacts/contact_resolver_service.dart';
import 'package:notidialca/core/platform/gateway/native/gateway_native_bridge.dart';
import 'package:notidialca/core/platform/gateway/native/gateway_native_event.dart';
import 'package:notidialca/core/platform/gateway/native/gateway_ui_bridge.dart';
import 'package:notidialca/features/calls/domain/repositories/call_repository.dart';
import 'package:notidialca/features/calls/domain/usecases/end_call_usecase.dart';
import 'package:notidialca/features/calls/domain/usecases/register_incoming_call_usecase.dart';
import 'package:notidialca/features/sms/domain/repositories/sms_repository.dart';
import 'package:notidialca/features/sms/domain/usecases/receive_sms_usecase.dart';
import 'package:notidialca/features/sync/domain/entities/sync_event_entity.dart';
import 'package:notidialca/features/sync/domain/repositories/sync_repository.dart';
import 'package:notidialca/features/sync/domain/usecases/get_pending_sync_events_usecase.dart';

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

  final _connectionStateController = StreamController<GatewayClientConnectionInfo>.broadcast();

  Stream<GatewayClientConnectionInfo> get connectionStateStream => _connectionStateController.stream;

  String? get connectedClientDeviceId => _connectedClientDeviceId;

  static const int _port = 8080;

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
      onHandshakeRequest: _handleHandshakeRequest,
      onSyncRequested: _handleSyncRequested,
      onSyncAckReceived: _handleSyncAck,
      onClientDisconnected: _handleClientDisconnected,
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
    _logger.i('GatewayService: Service started successfully');
  }

  Future<void> stop() async {
    await _nativeEventSubscription?.cancel();
    _nativeEventSubscription = null;
    nativeBridge.stopListening();
    await _wsServer?.stop();
    _wsServer = null;
    _connectedClientDeviceId = null;
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
    }
  }

  Future<void> _onSmsReceived(
    GatewayNativeSmsReceived event,
    String sourceDeviceId,
  ) async {
    final contactName = await contactResolverService.resolveContactName(event.phoneNumber);
    final result = await receiveSmsUseCase.call(
      phoneNumber: event.phoneNumber,
      content: event.content,
      sourceDeviceId: sourceDeviceId,
      contactName: contactName,
      receivedAt: event.receivedAt,
    );

    result.when(
      ok: (message) {
        _wsServer?.broadcastSmsReceived(
          WsSmsReceivedPayload(
            id: message.id,
            phoneNumber: event.phoneNumber,
            content: event.content,
            receivedAt: event.receivedAt,
            sourceDeviceId: sourceDeviceId,
            contactName: contactName,
          ),
        );
      },
      failure: (failure) {
        _logger.e(
          'GatewayService: Error processing incoming SMS',
          error: failure,
        );
      },
    );
  }

  Future<void> _onCallIncoming(
    GatewayNativeCallIncoming event,
    String sourceDeviceId,
  ) async {
    _lastRingingPhoneNumber = event.phoneNumber;

    final contactName = await contactResolverService.resolveContactName(event.phoneNumber);

    final result = await registerIncomingCallUseCase.call(
      phoneNumber: event.phoneNumber,
      callType: CallType.incoming,
      sourceDeviceId: sourceDeviceId,
      contactName: contactName,
      startedAt: event.startedAt,
    );
    result.when(
      ok: (call) {
        _wsServer?.broadcastCallIncoming(
          WsCallIncomingPayload(
            id: call.id,
            phoneNumber: event.phoneNumber,
            startedAt: event.startedAt,
            sourceDeviceId: sourceDeviceId,
            contactName: contactName,
          ),
        );
      },
      failure: (failure) {
        _logger.e(
          'GatewayService: Error processing incoming call',
          error: failure,
        );
      },
    );
  }

  Future<void> _onCallEnded(
    GatewayNativeCallEnded event,
    String sourceDeviceId,
  ) async {
    final phoneNumber = _lastRingingPhoneNumber;
    if (phoneNumber == null) {
      _logger.w(
        'GatewayService: Received call ended event, but no record of last ringing phone number',
      );
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
          ),
        );
      },
      failure: (failure) {
        _logger.e(
          'GatewayService: Error processing call ended event',
          error: failure,
        );
      },
    );
  }

  Future<bool> _handleHandshakeRequest(
    String? pairingToken,
    String clientDeviceId,
  ) async {
    if (pairingToken != null) {
      final isValid = pairingToken == _activePairingToken;
      if (isValid) {
        _activePairingToken = null;
        _onClientConnected(clientDeviceId);
      } 
      return isValid;
    }

    final device = await database.devicesDao.findById(clientDeviceId);
    final isLinked = device != null && device.pairingStatus.name == 'linked';
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
    uiBridge.sendConnectionUpdate(isConnected: true, clientDeviceId: clientDeviceId);
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
    final result = await getPendingSyncEventsUseCase
        .call();
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
        ),
      );
    }
    final result = await callRepository.findById(entityId) as Result<dynamic>;
    final call = result.valueOrNull;
    if (call == null) return null;

    final isFinished = call.endedAt != null;
    if (isFinished) {
      return WsSyncEventDto(
        eventId: eventId,
        type: 'call_ended',
        callEnded: WsCallEndedPayload(
          id: call.id as String,
          endedAt: call.endedAt as DateTime,
          sourceDeviceId: call.sourceDeviceId as String,
          phoneNumber: call.phoneNumber as String,
        ),
      );
    }
    return WsSyncEventDto(
      eventId: eventId,
      type: 'call_incoming',
      callIncoming: WsCallIncomingPayload(
        id: call.id as String,
        phoneNumber: call.phoneNumber as String,
        startedAt: call.startedAt as DateTime,
        sourceDeviceId: call.sourceDeviceId as String,
        contactName: call.contactName as String?,
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
