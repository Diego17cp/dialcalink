// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_handshake_ok_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsHandshakeOkPayload _$WsHandshakeOkPayloadFromJson(
  Map<String, dynamic> json,
) => WsHandshakeOkPayload(
  gatewayDeviceId: json['gatewayDeviceId'] as String,
  gatewayName: json['gatewayName'] as String,
);

Map<String, dynamic> _$WsHandshakeOkPayloadToJson(
  WsHandshakeOkPayload instance,
) => <String, dynamic>{
  'gatewayDeviceId': instance.gatewayDeviceId,
  'gatewayName': instance.gatewayName,
};
