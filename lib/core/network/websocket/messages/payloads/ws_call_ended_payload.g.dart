// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_call_ended_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsCallEndedPayload _$WsCallEndedPayloadFromJson(Map<String, dynamic> json) =>
    WsCallEndedPayload(
      id: json['id'] as String,
      endedAt: const EpochMillisConverter().fromJson(
        (json['endedAt'] as num).toInt(),
      ),
      sourceDeviceId: json['sourceDeviceId'] as String,
      phoneNumber: json['phoneNumber'] as String,
      callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
    );

Map<String, dynamic> _$WsCallEndedPayloadToJson(WsCallEndedPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceDeviceId': instance.sourceDeviceId,
      'phoneNumber': instance.phoneNumber,
      'callType': _$CallTypeEnumMap[instance.callType]!,
      'endedAt': const EpochMillisConverter().toJson(instance.endedAt),
    };

const _$CallTypeEnumMap = {
  CallType.incoming: 'incoming',
  CallType.outgoing: 'outgoing',
  CallType.missed: 'missed',
};
