import 'package:json_annotation/json_annotation.dart';

import './ws_payloads.dart';

part 'ws_handshake_error_payload.g.dart';

// Gateway -> Client
@JsonSerializable()
class WsHandshakeErrorPayload extends WsPayload {
  const WsHandshakeErrorPayload({
    required this.reason,
  });

  final String reason;

  factory WsHandshakeErrorPayload.fromJson(Map<String, dynamic> json) => _$WsHandshakeErrorPayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WsHandshakeErrorPayloadToJson(this);
}