import 'package:json_annotation/json_annotation.dart';

import './ws_payloads.dart';

part 'ws_handshake_ok_payload.g.dart';

// Gateway -> Client
@JsonSerializable()
class WsHandshakeOkPayload extends WsPayload {
  const WsHandshakeOkPayload({
    required this.gatewayDeviceId,
    required this.gatewayName,
  });

  final String gatewayDeviceId;
  final String gatewayName;

  factory WsHandshakeOkPayload.fromJson(Map<String, dynamic> json) => _$WsHandshakeOkPayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WsHandshakeOkPayloadToJson(this);
}