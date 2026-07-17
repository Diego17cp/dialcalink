import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ws_sync_contacts_request_payload.g.dart';

@JsonSerializable()
class WsSyncContactsRequestPayload extends WsPayload {
  const WsSyncContactsRequestPayload();

  factory WsSyncContactsRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$WsSyncContactsRequestPayloadFromJson(json);
      
  @override
  Map<String, dynamic> toJson() => _$WsSyncContactsRequestPayloadToJson(this);
}