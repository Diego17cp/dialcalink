import 'package:json_annotation/json_annotation.dart';

import './ws_payloads.dart';

part 'ws_sync_response_payload.g.dart';

@JsonSerializable()
class WsSyncEventDto {
  const WsSyncEventDto({
    required this.eventId,
    required this.type,
    this.sms,
    this.callIncoming,
    this.callEnded
  });

  final String eventId;
  final String type;
  final WsSmsReceivedPayload? sms;
  final WsCallIncomingPayload? callIncoming;
  final WsCallEndedPayload? callEnded;


  factory WsSyncEventDto.fromJson(Map<String, dynamic> json) => _$WsSyncEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WsSyncEventDtoToJson(this);
}

// Gateway -> Client
@JsonSerializable()
class WsSyncResponsePayload extends WsPayload {
  const WsSyncResponsePayload({
    required this.events,
  });

  final List<WsSyncEventDto> events;

  factory WsSyncResponsePayload.fromJson(Map<String, dynamic> json) => _$WsSyncResponsePayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WsSyncResponsePayloadToJson(this);
}