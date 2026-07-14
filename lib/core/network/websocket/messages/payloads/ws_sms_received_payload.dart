import 'package:dialcalink/core/database/drift/tables/sms_messages_table.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dialcalink/core/utils/epoch_millis_converter.dart';

import './ws_payloads.dart';

part 'ws_sms_received_payload.g.dart';

// Gateway -> Client
@JsonSerializable()
class WsSmsReceivedPayload extends WsPayload {
  const WsSmsReceivedPayload({
    required this.id,
    required this.phoneNumber,
    required this.receivedAt,
    required this.sourceDeviceId,
    this.contactName,
    this.content = '', 
    required this.direction,
  });

  final String id;
  final String phoneNumber;
  final String? contactName;
  final String content;
  final String sourceDeviceId;

  @EpochMillisConverter()
  final DateTime receivedAt;

  @JsonKey(defaultValue: SmsDirection.incoming)
  final SmsDirection direction;

  factory WsSmsReceivedPayload.fromJson(Map<String, dynamic> json) => _$WsSmsReceivedPayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WsSmsReceivedPayloadToJson(this);
}