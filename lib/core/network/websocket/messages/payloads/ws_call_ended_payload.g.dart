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
    );

Map<String, dynamic> _$WsCallEndedPayloadToJson(WsCallEndedPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endedAt': const EpochMillisConverter().toJson(instance.endedAt),
    };
