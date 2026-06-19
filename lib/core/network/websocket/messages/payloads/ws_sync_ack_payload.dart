import 'package:json_annotation/json_annotation.dart';

import './ws_payloads.dart';

part 'ws_sync_ack_payload.g.dart';

// Client -> Gateway
@JsonSerializable()
class WsSyncAckPayload extends WsPayload {
  const WsSyncAckPayload({required this.eventId});

  final String eventId;

  factory WsSyncAckPayload.fromJson(Map<String, dynamic> json) => _$WsSyncAckPayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WsSyncAckPayloadToJson(this);

}