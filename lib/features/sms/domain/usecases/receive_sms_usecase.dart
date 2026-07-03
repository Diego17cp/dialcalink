import 'package:uuid/uuid.dart';

import 'package:dialcalink/core/database/drift/tables/sync_events_table.dart' show SyncEntityType, SyncEventType;
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/sms/domain/entities/sms_message_entity.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';
import 'package:dialcalink/features/sms/domain/repositories/sms_repository.dart';
import 'package:dialcalink/features/sync/domain/repositories/sync_repository.dart';

// Gateway excl.

class ReceiveSmsUseCase {
  ReceiveSmsUseCase(this._smsRepository, this._syncRepository);

  final SmsRepository _smsRepository;
  final SyncRepository _syncRepository;
  final Uuid _uuid = const Uuid();

  Future<Result<SmsMessageEntity>> call({
    required String phoneNumber,
    required String content,
    required String sourceDeviceId,
    String? contactName,
    DateTime? receivedAt,
  }) async {
    final message = SmsMessageEntity(
      id: _uuid.v4(),
      phoneNumber: phoneNumber,
      content: content,
      receivedAt: receivedAt ?? DateTime.now(),
      sourceDeviceId: sourceDeviceId,
      isRead: false,
      contactName: contactName,
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