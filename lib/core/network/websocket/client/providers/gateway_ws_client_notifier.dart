import 'package:flutter/cupertino.dart';
import 'package:notidialca/core/database/drift/tables/call_logs_table.dart';
import 'package:notidialca/core/network/websocket/client/gateway_ws_client.dart';
import 'package:notidialca/core/network/websocket/client/ws_connection_state.dart';
import 'package:notidialca/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:notidialca/features/calls/domain/entities/call_log_entity.dart';
import 'package:notidialca/features/calls/presentation/providers/call_providers.dart';
import 'package:notidialca/features/sms/domain/entities/sms_message_entity.dart';
import 'package:notidialca/features/sms/presentation/providers/sms_providers.dart';
import 'package:notidialca/core/notifications/providers/notification_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_ws_client_notifier.g.dart';

@Riverpod(keepAlive: true)
class GatewayWsClientNotifier extends _$GatewayWsClientNotifier {
  GatewayWsClient? _client;

  @override
  WsConnectionState build() {
    ref.onDispose(() {
      _client?.disconnect();
    });
    return const WsDisconnected();
  }

  void connect({
    required String ip,
    required int port,
    required String clientDeviceId,
  }) async {
    final oldClient = _client;
    if (oldClient != null) {
      await _client?.disconnect();
    }
    final newClient = GatewayWsClient.forSession(
      ip: ip,
      port: port,
      clientDeviceId: clientDeviceId,
    );
    _client = newClient;

    newClient.connectionState.listen((wsState) {
      if (_client == newClient) state = wsState;
      debugPrint('[DIALCA][UI] Estado actualizado en Notifier: $wsState');
    });

    newClient.incomingEvents.listen((event) {
      if (_client == newClient) _dispatchEvent(event);
    });
    newClient.connect();
  }

  Future<void> disconnect() async {
    await _client?.disconnect();
    _client = null;
    state = const WsDisconnected();
  }

  Future<void> _dispatchEvent(WsIncomingEvent event) async {
    switch (event) {
      case WsSmsEvent(payload: final payload):
        await _applySms(payload);
      case WsCallIncomingEvent(payload: final payload):
        await _applyCallIncoming(payload);
      case WsCallEndedEvent(payload: final payload):
        await _applyCallEnded(payload);
      case WsSyncResponseEvent(payload: final payload):
        await _applySyncResponse(payload);
    }
  }

  Future<void> _applySms(WsSmsReceivedPayload payload) async {
    debugPrint('[DIALCA][CLIENT] SMS recibido via WS de: ${payload.phoneNumber}');
    final useCase = ref.read(applySyncedSmsUseCaseProvider);
    final entity = SmsMessageEntity(
      id: payload.id,
      phoneNumber: payload.phoneNumber,
      content: payload.content,
      receivedAt: payload.receivedAt,
      sourceDeviceId: payload.sourceDeviceId,
      isRead: false,
      contactName: payload.contactName,
    );
    final result = await useCase.call(entity);
    result.when(
      ok: (_) {
        debugPrint('[DIALCA][CLIENT] SMS guardado en DB local: ${payload.id}');
        final notificationService = ref.read(notificationServiceProvider);
        notificationService.showSmsNotification(
          smsId: payload.id,
          displayName: payload.contactName ?? payload.phoneNumber,
          content: payload.content,
          payload: payload.phoneNumber,
        );
      },
      failure: (f) {
        debugPrint('[DIALCA][CLIENT] ERROR guardando SMS: ${f.message}');
      },
    );
  }

  Future<void> _applyCallIncoming(WsCallIncomingPayload payload) async {
    debugPrint('[DIALCA][CLIENT] Llamada recibida via WS de: ${payload.phoneNumber}');
    final useCase = ref.read(applySyncedCallUseCaseProvider);
    final entity = CallLogEntity(
      id: payload.id,
      phoneNumber: payload.phoneNumber,
      callType: CallType.incoming,
      sourceDeviceId: payload.sourceDeviceId,
      contactName: payload.contactName,
      startedAt: payload.startedAt,
      endedAt: null,
    );
    final result = await useCase.call(entity);

    result.when(
      ok: (_) {
        debugPrint('[DIALCA][CLIENT] Llamada guardada en DB local: ${payload.id}');
        final notificationService = ref.read(notificationServiceProvider);
        notificationService.showCallNotification(
          callId: payload.id,
          displayName: payload.contactName ?? payload.phoneNumber,
          phoneNumber: payload.phoneNumber,
        );
      },
      failure: (f) {
        debugPrint('[DIALCA][CLIENT] ERROR guardando llamada: ${f.message}');
      },
    );
  }

  Future<void> _applyCallEnded(WsCallEndedPayload payload) async {
    final useCase = ref.read(applySyncedCallUseCaseProvider);
    final entity = CallLogEntity(
      id: payload.id,
      phoneNumber: payload.phoneNumber,
      callType: CallType.incoming,
      sourceDeviceId: payload.sourceDeviceId,
      contactName: null,
      startedAt: null,
      endedAt: payload.endedAt,
    );
    await useCase.call(entity);
  }

  Future<void> _applySyncResponse(WsSyncResponsePayload payload) async {
    for (final event in payload.events) {
      if (event.sms != null) {
        await _applySms(event.sms!);
      } else if (event.callIncoming != null) {
        await _applyCallIncoming(event.callIncoming!);
      } else if (event.callEnded != null) {
        await _applyCallEnded(event.callEnded!);
      }
      _client?.sendSyncAck(event.eventId);
    }
  }
}
