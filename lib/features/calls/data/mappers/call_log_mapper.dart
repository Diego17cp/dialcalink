import 'package:drift/drift.dart';
import 'package:dialcalink/core/database/drift/app_database.dart';
import 'package:dialcalink/features/calls/domain/entities/call_log_entity.dart';

class CallLogMapper {
  const CallLogMapper._();

  static CallLogEntity toEntity(CallLog row) {
    return CallLogEntity(
      id: row.id,
      phoneNumber: row.phoneNumber,
      callType: row.callType,
      sourceDeviceId: row.sourceDeviceId,
      contactName: row.contactName,
      startedAt: row.startedAt,
      endedAt: row.endedAt,
    );
  }

  static CallLogsCompanion toCompanion(CallLogEntity entity) {
    return CallLogsCompanion(
      id: Value(entity.id),
      phoneNumber: Value(entity.phoneNumber),
      callType: Value(entity.callType),
      sourceDeviceId: Value(entity.sourceDeviceId),
      contactName: entity.contactName == null
        ? const Value.absent()
        : Value(entity.contactName),
      startedAt: entity.startedAt == null
        ? const Value.absent()
        : Value(entity.startedAt),
      endedAt: entity.endedAt == null
        ? const Value.absent()
        : Value(entity.endedAt),
    );
  }
}