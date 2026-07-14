import 'package:dialcalink/core/database/drift/tables/sms_messages_table.dart';
import 'package:dialcalink/core/database/drift/tables/sync_events_table.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/sms/domain/entities/sms_message_entity.dart';
import 'package:dialcalink/features/sms/domain/repositories/sms_repository.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';
import 'package:dialcalink/features/sync/domain/repositories/sync_repository.dart';
import 'package:uuid/uuid.dart';

class SendSmsUseCase {
  SendSmsUseCase(
    this._smsRepository,
    this._syncRepository,
    this._sendSmsNative,
  );
  final SmsRepository _smsRepository;
  final SyncRepository _syncRepository;
  final Future<Result<void>> Function(String to, String content) _sendSmsNative;
  final Uuid _uuid = const Uuid();

  Future<Result<SmsMessageEntity>> call({
    required String to,
    required String content,
    required String sourceDeviceId,
  }) async {
    final nativeResult = await _sendSmsNative(to, content);
    if (nativeResult.isFailure) {
      return Result.failure(nativeResult.failureOrNull!);
    }

    final message = SmsMessageEntity(
      id: _uuid.v4(),
      phoneNumber: to,
      content: content,
      receivedAt: DateTime.now(),
      sourceDeviceId: sourceDeviceId,
      isRead: true,
      direction: SmsDirection.outgoing,
      contactName: null,
    );
    final insertResult = await _smsRepository.insertMessage(message);
    if (insertResult.isFailure) {
      return Result.failure(insertResult.failureOrNull!);
    }
    final event = SyncEventEntity(
      id: _uuid.v4(),
      entityType: SyncEntityType.smsMessage,
      entityId: message.id,
      eventType: SyncEventType.created,
      createdAt: message.receivedAt,
      synced: false,
    );
    final enqueueResult = await _syncRepository.enqueueEvent(event);
    if (enqueueResult.isFailure) {
      return Result.failure(enqueueResult.failureOrNull!);
    }
    return Result.ok(message);
  }
}
