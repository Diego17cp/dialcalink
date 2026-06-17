import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/drift/tables/call_logs_table.dart' show CallType;

part 'call_log_entity.freezed.dart';

@freezed
class CallLogEntity with _$CallLogEntity {
  const factory CallLogEntity({
    required String id,
    required String phoneNumber,
    required CallType callType,
    required String sourceDeviceId,
    String? contactName,
    DateTime? startedAt,
    DateTime? endedAt,
  }) = _CallLogEntity;

  const CallLogEntity._();

  String get displayName => contactName ?? phoneNumber;
  bool get isFinished => endedAt != null;
  Duration? get duration {
    if (startedAt == null || endedAt == null) return null;
    return endedAt!.difference(startedAt!);
  }
}