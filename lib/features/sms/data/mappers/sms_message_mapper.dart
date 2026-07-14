import 'package:drift/drift.dart';

import '../../../../core/database/drift/app_database.dart';
import '../../domain/entities/sms_message_entity.dart';

class SmsMessageMapper {
  const SmsMessageMapper._();

  static SmsMessageEntity toEntity(SmsMessage row) {
    return SmsMessageEntity(
      id: row.id,
      phoneNumber: row.phoneNumber,
      content: row.content,
      receivedAt: row.receivedAt,
      sourceDeviceId: row.sourceDeviceId,
      isRead: row.isRead,
      contactName: row.contactName,
      direction: row.direction,
    );
  }

  static SmsMessagesCompanion toCompanion(SmsMessageEntity entity) {
    return SmsMessagesCompanion(
      id: Value(entity.id),
      phoneNumber: Value(entity.phoneNumber),
      content: Value(entity.content),
      receivedAt: Value(entity.receivedAt),
      sourceDeviceId: Value(entity.sourceDeviceId),
      isRead: Value(entity.isRead),
      contactName: entity.contactName == null
        ? const Value.absent()
        : Value(entity.contactName),
      direction: Value(entity.direction),
    );
  }
}