import 'package:json_annotation/json_annotation.dart';
import 'package:notidialca/core/utils/epoch_millis_converter.dart';

import './ws_payloads.dart';

part 'ws_call_incoming_payload.g.dart';

// Gateway -> Client
@JsonSerializable()
class WsCallIncomingPayload extends WsPayload {
  const WsCallIncomingPayload({
    required this.id,
    required this.phoneNumber,
    required this.startedAt,
    this.contactName,
  });

  final String id;
  final String phoneNumber;
  final String? contactName;
  @EpochMillisConverter()
  final DateTime startedAt;

  factory WsCallIncomingPayload.fromJson(Map<String, dynamic> json) => _$WsCallIncomingPayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WsCallIncomingPayloadToJson(this);
}