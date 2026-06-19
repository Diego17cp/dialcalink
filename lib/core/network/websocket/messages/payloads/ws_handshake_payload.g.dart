// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_handshake_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsHandshakePayload _$WsHandshakePayloadFromJson(Map<String, dynamic> json) =>
    WsHandshakePayload(
      pairingToken: json['pairingToken'] as String,
      clientDeviceId: json['clientDeviceId'] as String,
    );

Map<String, dynamic> _$WsHandshakePayloadToJson(WsHandshakePayload instance) =>
    <String, dynamic>{
      'pairingToken': instance.pairingToken,
      'clientDeviceId': instance.clientDeviceId,
    };
