import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ws_sms_sent_payload.g.dart';

@JsonSerializable()
class WsSmsSentPayload extends WsPayload {
  const WsSmsSentPayload({
    required this.id,
    required this.to,
    required this.success,
    this.errorReason,
  });
  final String id;
  final String to;
  final bool success;
  final String? errorReason;
  factory WsSmsSentPayload.fromJson(Map<String, dynamic> json) =>
      _$WsSmsSentPayloadFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WsSmsSentPayloadToJson(this);
}
