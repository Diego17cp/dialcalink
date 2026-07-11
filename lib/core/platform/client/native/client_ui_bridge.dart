import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

enum ClientConnectionStateBridge {
  disconnected,
  connecting,
  connected,
  ready,
  reconnecting,
  handshakeRejected,
  error,
}

extension ClientConnectionStateBridgeX on ClientConnectionStateBridge {
  static ClientConnectionStateBridge fromString(String raw) {
    return ClientConnectionStateBridge.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => ClientConnectionStateBridge.disconnected,
    );
  }
}

class ClientConnectionStateUpdate {
  const ClientConnectionStateUpdate({required this.state, this.gatewayName});

  final ClientConnectionStateBridge state;

  final String? gatewayName;
}

class ClientUiBridge {
  ClientUiBridge({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  static const _eventChannel = EventChannel(
    'com.dialcadev.dialcalink/client_ui_bridge_events',
  );
  static const _methodChannel = MethodChannel(
    'com.dialcadev.dialcalink/client_ui_bridge_method',
  );

  static const _serviceControlChannel = MethodChannel(
    'com.dialcadev.dialcalink/client_control',
  );

  StreamSubscription? _subscription;
  final _stateController =
      StreamController<ClientConnectionStateUpdate>.broadcast();

  Stream<ClientConnectionStateUpdate> get connectionStateUpdate =>
      _stateController.stream;

  void startListeningFromUi() {
    _subscription?.cancel();
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic raw) {
        if (raw is! Map) return;
        final type = raw['type'] as String?;
        if (type != 'connection_state_changed') return;

        final stateStr = raw['state'] as String? ?? 'disconnected';
        final gatewayName = raw['gatewayName'] as String?;

        _stateController.add(
          ClientConnectionStateUpdate(
            state: ClientConnectionStateBridgeX.fromString(stateStr),
            gatewayName: gatewayName,
          ),
        );
      },
      onError: (Object e) {
        _logger.e('ClientUiBridge: error en EventChannel', error: e);
      },
    );
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  Future<void> requestReconnect() async {
    try {
      await _methodChannel.invokeMethod('reconnect');
    } on PlatformException catch (e) {
      _logger.e('ClientUiBridge: error solicitando reconexion', error: e);
    }
  }

  Future<void> requestDisconnect() async {
    try {
      await _methodChannel.invokeMethod('disconnect');
    } on PlatformException catch (e) {
      _logger.e('ClientUiBridge: error solicitando desconexion', error: e);
    }
  }

  Future<void> emitConnectionState(
    ClientConnectionStateBridge state, {
    String? gatewayName,
  }) async {
    try {
      await _serviceControlChannel.invokeMethod('emitConnectionState', {
        'state': state.name,
        'gatewayName': gatewayName,
      });
    } on PlatformException catch (e) {
      _logger.e('ClientUiBridge: error emitiendo estado de conexion', error: e);
    }
  }

  StreamSubscription? _commandSubscription;
  final _commandController = StreamController<String>.broadcast();

  Stream<String> get commands => _commandController.stream;

  void startListeningCommandsFromService() {
    _commandSubscription?.cancel();
    _commandSubscription =
        const EventChannel(
          'com.dialcadev.dialcalink/client_events',
        ).receiveBroadcastStream().listen(
          (dynamic raw) {
            if (raw is! Map) return;
            final type = raw['type'] as String?;
            if (type != null) _commandController.add(type);
          },
          onError: (Object e) {
            _logger.e('ClientUiBridge: error en commands channel', error: e);
          },
        );
  }

  void dispose() {
    stopListening();
    _commandSubscription?.cancel();
    _stateController.close();
    _commandController.close();
  }
}
