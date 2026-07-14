// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_sms_sent_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsSmsSentPayload _$WsSmsSentPayloadFromJson(Map<String, dynamic> json) =>
    WsSmsSentPayload(
      id: json['id'] as String,
      to: json['to'] as String,
      success: json['success'] as bool,
      errorReason: json['errorReason'] as String?,
    );

Map<String, dynamic> _$WsSmsSentPayloadToJson(WsSmsSentPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'to': instance.to,
      'success': instance.success,
      'errorReason': instance.errorReason,
    };
