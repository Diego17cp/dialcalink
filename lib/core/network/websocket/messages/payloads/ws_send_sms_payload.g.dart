// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_send_sms_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsSendSmsPayload _$WsSendSmsPayloadFromJson(Map<String, dynamic> json) =>
    WsSendSmsPayload(
      to: json['to'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$WsSendSmsPayloadToJson(WsSendSmsPayload instance) =>
    <String, dynamic>{'to': instance.to, 'content': instance.content};
