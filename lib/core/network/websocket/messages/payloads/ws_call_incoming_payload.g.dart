// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_call_incoming_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsCallIncomingPayload _$WsCallIncomingPayloadFromJson(
  Map<String, dynamic> json,
) => WsCallIncomingPayload(
  id: json['id'] as String,
  phoneNumber: json['phoneNumber'] as String,
  startedAt: const EpochMillisConverter().fromJson(
    (json['startedAt'] as num).toInt(),
  ),
  sourceDeviceId: json['sourceDeviceId'] as String,
  callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
  contactName: json['contactName'] as String?,
);

Map<String, dynamic> _$WsCallIncomingPayloadToJson(
  WsCallIncomingPayload instance,
) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'contactName': instance.contactName,
  'sourceDeviceId': instance.sourceDeviceId,
  'callType': _$CallTypeEnumMap[instance.callType]!,
  'startedAt': const EpochMillisConverter().toJson(instance.startedAt),
};

const _$CallTypeEnumMap = {
  CallType.incoming: 'incoming',
  CallType.outgoing: 'outgoing',
  CallType.missed: 'missed',
};
