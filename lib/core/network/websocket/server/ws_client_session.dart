import 'dart:io';

class WsClientSession {
  WsClientSession({required this.clientDeviceId, required WebSocket socket})
    : _socket = socket,
      lastPongAt = DateTime.now();

  final String clientDeviceId;
  final WebSocket _socket;

  bool _isHandshakeComplete = false;
  bool get isHandshakeComplete => _isHandshakeComplete;

  DateTime lastPongAt;

  void markHandshakeComplete() => _isHandshakeComplete = true;
  void markPongReceived() => lastPongAt = DateTime.now();

  bool isTimedOut(Duration timeout) {
    return DateTime.now().difference(lastPongAt) > timeout;
  }

  void send(String message) {
    if (_socket.readyState == WebSocket.open) {
      _socket.add(message);
    }
  }

  Future<void> close([int? code, String? reason]) {
    return _socket.close(code, reason);
  }

  Stream<String> get messages =>
      _socket.where((event) => event is String).cast<String>();
}
