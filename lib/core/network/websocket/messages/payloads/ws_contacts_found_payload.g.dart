// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_contacts_found_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsContactDto _$WsContactDtoFromJson(Map<String, dynamic> json) => WsContactDto(
  name: json['name'] as String,
  number: json['number'] as String,
);

Map<String, dynamic> _$WsContactDtoToJson(WsContactDto instance) =>
    <String, dynamic>{'name': instance.name, 'number': instance.number};

WsContactsFoundPayload _$WsContactsFoundPayloadFromJson(
  Map<String, dynamic> json,
) => WsContactsFoundPayload(
  contacts: (json['contacts'] as List<dynamic>)
      .map((e) => WsContactDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WsContactsFoundPayloadToJson(
  WsContactsFoundPayload instance,
) => <String, dynamic>{'contacts': instance.contacts};
