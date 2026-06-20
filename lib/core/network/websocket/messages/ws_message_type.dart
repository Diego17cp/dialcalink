enum WsMessageType {
  // Gateway -> Client
  handshakeOk,
  handshakeError,
  smsReceived,
  callIncoming,
  callEnded,
  syncResponse,
  ping,

  // Client -> Gateway
  handshake,
  syncRequest,
  syncAck,
  pong,

  unknown,
}

extension WsMessageTypeX on WsMessageType {
  static const _toJson = {
    WsMessageType.handshakeOk: 'handshake_ok',
    WsMessageType.handshakeError: 'handshake_error',
    WsMessageType.smsReceived: 'sms_received',
    WsMessageType.callIncoming: 'call_incoming',
    WsMessageType.callEnded: 'call_ended',
    WsMessageType.syncResponse: 'sync_response',
    WsMessageType.handshake: 'handshake',
    WsMessageType.syncRequest: 'sync_request',
    WsMessageType.syncAck: 'sync_ack',
    WsMessageType.ping: 'ping',
    WsMessageType.pong: 'pong',
  };

  String toJsonValue() => _toJson[this] ?? 'unknown';

  static WsMessageType fromJsonToValue(String raw) => _toJson.entries
      .firstWhere(
        (entry) => entry.value == raw,
        orElse: () => const MapEntry(WsMessageType.unknown, 'unknown'),
      )
      .key;
}
