import './ws_payloads.dart';

// Client -> Gateway

class WsSyncRequestPayload extends WsPayload {
  const WsSyncRequestPayload();

  @override
  Map<String, dynamic> toJson() => {};
}