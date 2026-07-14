import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ws_send_sms_payload.g.dart';

@JsonSerializable()
class WsSendSmsPayload extends WsPayload {
  const WsSendSmsPayload({required this.to, required this.content});
  final String to;
  final String content;
  factory WsSendSmsPayload.fromJson(Map<String, dynamic> json) =>
      _$WsSendSmsPayloadFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WsSendSmsPayloadToJson(this);
}
