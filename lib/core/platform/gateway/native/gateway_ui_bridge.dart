import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class GatewayUiBridge {
  GatewayUiBridge({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  static const _methodChannel = MethodChannel(
    'com.dialcadev.dialcalink/gateway_ui_bridge_method',
  );
  static const _eventChannel = EventChannel(
    'com.dialcadev.dialcalink/gateway_ui_bridge_events',
  );

  StreamSubscription? _subscription;

  final _connectionController =
      StreamController<GatewayClientConnectionUpdate>.broadcast();

  final _tokenController = StreamController<String>.broadcast();

  Stream<GatewayClientConnectionUpdate> get connectionUpdates =>
      _connectionController.stream;

  Stream<String> get pairingTokenUpdates => _tokenController.stream;

  void startListeningConnectionUpdates() {
    _subscription?.cancel();
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic raw) {
        if (raw is! Map) return;
        final type = raw['type'] as String?;
        if (type == 'client_connection_changed') {
          if (!_connectionController.isClosed) {
          _connectionController.add(
            GatewayClientConnectionUpdate(
              isConnected: raw['isConnected'] as bool? ?? false,
              clientDeviceId: raw['clientDeviceId'] as String?,
            ),
          );
          }
        } else if (type == 'pairing_token_updated') {
            final token = raw['token'] as String?;
            if (!_tokenController.isClosed) {
              if (token != null && token.isNotEmpty) {
                _tokenController.add(token);
              }
            }
        }
      },
      onError: (Object e) {
        _logger.e(
          'GatewayUiBridge: Error receiving connection updates',
          error: e,
        );
      },
    );
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  Future<void> sendPairingToken(String token) async {
    try {
      await _methodChannel.invokeMethod('setPairingToken', {'token': token});
    } catch (e) {
      _logger.e('GatewayUiBridge: Error sending pairing token', error: e);
    }
  }

  Future<void> sendConnectionUpdate({
    required bool isConnected,
    String? clientDeviceId
  }) async {
    try {
      await _methodChannel.invokeMethod('emitConnectionUpdate', {
        'isConnected': isConnected,
        'clientDeviceId': clientDeviceId,
      });
    } on PlatformException catch (e) {
      _logger.e('GatewayUiBridge: Error sending connection update', error: e);
    }
  }

  void dispose() {
    stopListening();
    _connectionController.close();
    _tokenController.close();
  }
}

class GatewayClientConnectionUpdate {
  const GatewayClientConnectionUpdate({
    required this.isConnected,
    this.clientDeviceId,
  });
  final bool isConnected;
  final String? clientDeviceId;
}
