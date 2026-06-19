import './ws_payloads.dart';

class WsUnknownPayload extends WsPayload {
  const WsUnknownPayload();

  @override
  Map<String, dynamic> toJson() => {};
}