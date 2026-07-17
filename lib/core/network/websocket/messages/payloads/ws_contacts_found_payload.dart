import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ws_contacts_found_payload.g.dart';

@JsonSerializable()
class WsContactDto {
  const WsContactDto({required this.name, required this.number});
  final String name;
  final String number;

  factory WsContactDto.fromJson(Map<String, dynamic> json) =>
      _$WsContactDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WsContactDtoToJson(this);
}

@JsonSerializable()
class WsContactsFoundPayload extends WsPayload {
  const WsContactsFoundPayload({required this.contacts});
  final List<WsContactDto> contacts;

  factory WsContactsFoundPayload.fromJson(Map<String, dynamic> json) =>
      _$WsContactsFoundPayloadFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WsContactsFoundPayloadToJson(this);
}