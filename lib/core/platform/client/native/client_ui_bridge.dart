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

class SmsSentResult {
  const SmsSentResult({
    required this.id,
    required this.success,
    this.errorReason,
  });
  final String id;
  final bool success;
  final String? errorReason;
}

class SendSmsCommand {
  const SendSmsCommand({required this.to, required this.content});
  final String to;
  final String content;
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

  final _smsSentController = StreamController<SmsSentResult>.broadcast();
  Stream<SmsSentResult> get smsSentResults => _smsSentController.stream;

  final _sendSmsCommandController = StreamController<SendSmsCommand>.broadcast();
  Stream<SendSmsCommand> get sendSmsCommands => _sendSmsCommandController.stream;

  void startListeningFromUi() {
    _subscription?.cancel();
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic raw) {
        if (raw is! Map) return;
        final type = raw['type'] as String?;
        if (type == 'connection_state_changed') {
          final stateStr = raw['state'] as String? ?? 'disconnected';
          final gatewayName = raw['gatewayName'] as String?;
          _stateController.add(
            ClientConnectionStateUpdate(
              state: ClientConnectionStateBridgeX.fromString(stateStr),
              gatewayName: gatewayName,
            ),
          );
        } else if (type == 'sms_sent_result') {
          _smsSentController.add(
            SmsSentResult(
              id: raw['id'] as String ?? '',
              success: raw['success'] as bool ?? false,
              errorReason: raw['errorReason'] as String?,
            ),
          );
        }
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

  Future<void> requestSendSms(String to, String content) async {
    try {
      await _methodChannel.invokeMethod('sendSms', {
        'to': to,
        'content': content,
      });
    } on PlatformException catch (e) {
      _logger.e('ClientUiBridge: error solicitando envio de SMS', error: e);
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

  Future<void> emitSmsSentResult(
    String id,
    bool success,
    String? errorReason,
  ) async {
    try {
      await _serviceControlChannel.invokeMethod('emitSmsSentResult', {
        'id': id,
        'success': success,
        'errorReason': errorReason,
      });
    } on PlatformException catch (e) {
      _logger.e(
        'ClientUiBridge: error emitiendo resultado de envio de SMS',
        error: e,
      );
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
            if (type == 'send_sms_requested') {
              _sendSmsCommandController.add(SendSmsCommand(
                to: raw['to'] as String? ?? '',
                content: raw['content'] as String? ?? '',
              ));
            } else if (type != null) {
              _commandController.add(type);
            }
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
    _smsSentController.close();
    _sendSmsCommandController.close();
  }
}
