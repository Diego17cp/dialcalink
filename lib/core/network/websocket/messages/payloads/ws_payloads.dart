import 'package:dialcalink/core/network/websocket/messages/ws_message_type.dart';

import 'ws_handshake_payload.dart';
import 'ws_handshake_ok_payload.dart';
import 'ws_handshake_error_payload.dart';
import 'ws_sms_received_payload.dart';
import 'ws_ping_payload.dart';
import 'ws_pong_payload.dart';
import 'ws_call_incoming_payload.dart';
import 'ws_call_ended_payload.dart';
import 'ws_sync_request_payload.dart';
import 'ws_sync_response_payload.dart';
import 'ws_sync_ack_payload.dart';
import 'ws_unknown_payload.dart';

export 'ws_handshake_payload.dart';
export 'ws_handshake_ok_payload.dart';
export 'ws_handshake_error_payload.dart';
export 'ws_sms_received_payload.dart';
export 'ws_call_incoming_payload.dart';
export 'ws_call_ended_payload.dart';
export 'ws_sync_request_payload.dart';
export 'ws_sync_response_payload.dart';
export 'ws_sync_ack_payload.dart';
export 'ws_unknown_payload.dart';
export 'ws_ping_payload.dart';
export 'ws_pong_payload.dart';

abstract class WsPayload {
  const WsPayload();

  Map<String, dynamic> toJson();

  static WsPayload fromJson(WsMessageType type, Map<String, dynamic> json) {
    return switch (type) {
      WsMessageType.handshake => WsHandshakePayload.fromJson(json),
      WsMessageType.handshakeOk => WsHandshakeOkPayload.fromJson(json),
      WsMessageType.handshakeError => WsHandshakeErrorPayload.fromJson(json),
      WsMessageType.smsReceived => WsSmsReceivedPayload.fromJson(json),
      WsMessageType.callIncoming => WsCallIncomingPayload.fromJson(json),
      WsMessageType.callEnded => WsCallEndedPayload.fromJson(json),
      WsMessageType.syncRequest => const WsSyncRequestPayload(),
      WsMessageType.syncResponse => WsSyncResponsePayload.fromJson(json),
      WsMessageType.syncAck => WsSyncAckPayload.fromJson(json),
      WsMessageType.ping => const WsPingPayload(),
      WsMessageType.pong => const WsPongPayload(),
      WsMessageType.unknown => const WsUnknownPayload(),
    };
  }
}