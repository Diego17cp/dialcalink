// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_sms_received_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsSmsReceivedPayload _$WsSmsReceivedPayloadFromJson(
  Map<String, dynamic> json,
) => WsSmsReceivedPayload(
  id: json['id'] as String,
  phoneNumber: json['phoneNumber'] as String,
  receivedAt: const EpochMillisConverter().fromJson(
    (json['receivedAt'] as num).toInt(),
  ),
  contactName: json['contactName'] as String?,
  content: json['content'] as String? ?? '',
);

Map<String, dynamic> _$WsSmsReceivedPayloadToJson(
  WsSmsReceivedPayload instance,
) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'contactName': instance.contactName,
  'content': instance.content,
  'receivedAt': const EpochMillisConverter().toJson(instance.receivedAt),
};
