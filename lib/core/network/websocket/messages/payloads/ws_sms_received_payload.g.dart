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
  sourceDeviceId: json['sourceDeviceId'] as String,
  contactName: json['contactName'] as String?,
  content: json['content'] as String? ?? '',
  direction:
      $enumDecodeNullable(_$SmsDirectionEnumMap, json['direction']) ??
      SmsDirection.incoming,
);

Map<String, dynamic> _$WsSmsReceivedPayloadToJson(
  WsSmsReceivedPayload instance,
) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'contactName': instance.contactName,
  'content': instance.content,
  'sourceDeviceId': instance.sourceDeviceId,
  'receivedAt': const EpochMillisConverter().toJson(instance.receivedAt),
  'direction': _$SmsDirectionEnumMap[instance.direction]!,
};

const _$SmsDirectionEnumMap = {
  SmsDirection.incoming: 'incoming',
  SmsDirection.outgoing: 'outgoing',
};
