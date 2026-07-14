import 'package:dialcalink/core/database/drift/tables/sms_messages_table.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_message_entity.freezed.dart';

@freezed
class SmsMessageEntity with _$SmsMessageEntity {
  const factory SmsMessageEntity({
    required String id,
    required String phoneNumber,
    required String content,
    required DateTime receivedAt,
    required String sourceDeviceId,
    required bool isRead,
    String? contactName,
    required SmsDirection direction,
  }) = _SmsMessageEntity;

  const SmsMessageEntity._();

  String get displayName => contactName ?? phoneNumber;
}