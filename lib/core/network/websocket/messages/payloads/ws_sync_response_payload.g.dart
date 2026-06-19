// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_sync_response_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsSyncEventDto _$WsSyncEventDtoFromJson(Map<String, dynamic> json) =>
    WsSyncEventDto(
      eventId: json['eventId'] as String,
      type: json['type'] as String,
      sms: json['sms'] == null
          ? null
          : WsSmsReceivedPayload.fromJson(json['sms'] as Map<String, dynamic>),
      callIncoming: json['callIncoming'] == null
          ? null
          : WsCallIncomingPayload.fromJson(
              json['callIncoming'] as Map<String, dynamic>,
            ),
      callEnded: json['callEnded'] == null
          ? null
          : WsCallEndedPayload.fromJson(
              json['callEnded'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$WsSyncEventDtoToJson(WsSyncEventDto instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'type': instance.type,
      'sms': instance.sms,
      'callIncoming': instance.callIncoming,
      'callEnded': instance.callEnded,
    };

WsSyncResponsePayload _$WsSyncResponsePayloadFromJson(
  Map<String, dynamic> json,
) => WsSyncResponsePayload(
  events: (json['events'] as List<dynamic>)
      .map((e) => WsSyncEventDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WsSyncResponsePayloadToJson(
  WsSyncResponsePayload instance,
) => <String, dynamic>{'events': instance.events};
