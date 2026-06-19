import 'dart:convert';

import 'package:notidialca/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:notidialca/core/network/websocket/messages/ws_message_type.dart';

class WsMessage {
  const WsMessage({required this.type, required this.payload});

  final WsMessageType type;
  final WsPayload payload;

  String toJsonString() =>
      jsonEncode({'type': type.toJsonValue(), 'payload': payload.toJson()});

  static WsMessage fromJsonString(String raw) {
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final type = WsMessageTypeX.fromJsonToValue(map['type'] as String? ?? '');
      final payloadMap = map['payload'] as Map<String, dynamic>? ?? {};
      final payload = WsPayload.fromJson(type, payloadMap);
      return WsMessage(type: type, payload: payload);
    } catch (_) {
      return const WsMessage(
        type: WsMessageType.unknown,
        payload: WsUnknownPayload()
      );
    }
  }
}
