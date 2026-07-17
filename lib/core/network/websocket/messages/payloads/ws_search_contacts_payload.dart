import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ws_search_contacts_payload.g.dart';

@JsonSerializable()
class WsSearchContactsPayload extends WsPayload {
  const WsSearchContactsPayload({required this.query});
  final String query;

  factory WsSearchContactsPayload.fromJson(Map<String, dynamic> json) =>
      _$WsSearchContactsPayloadFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WsSearchContactsPayloadToJson(this);
}