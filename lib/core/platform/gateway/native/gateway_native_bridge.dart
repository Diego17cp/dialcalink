import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:notidialca/core/platform/gateway/native/gateway_native_event.dart';

class GatewayNativeBridge {
  GatewayNativeBridge({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  static const _eventChannel = EventChannel(
    'com.dialcadev.dialcalink/gateway_events',
  );
  static const _activityControlChannel = MethodChannel(
    'com.dialcadev.dialcalink/gateway_service_control',
  );

  StreamSubscription<dynamic>? _rawSubscription;
  final _eventsController = StreamController<GatewayNativeEvent>.broadcast();

  Stream<GatewayNativeEvent> get events => _eventsController.stream;

  void startListening() {
    _rawSubscription?.cancel();
    _rawSubscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic raw) {
        debugPrint('[DIALCA][BRIDGE] Evento nativo recibido: $raw');
        try {
          final event = GatewayNativeEvent.fromMap(raw as Map);
          debugPrint('[DIALCA][BRIDGE] Evento parseado: ${event.runtimeType}');
          _eventsController.add(event);
        } catch (e, st) {
          debugPrint('[DIALCA][BRIDGE] Error parseando evento: $e');
          _logger.e(
            'GatewayNativeBridge: Failed to parse native event',
            error: e,
            stackTrace: st,
          );
        }
      },
      onError: (Object error) {
        debugPrint('[DIALCA][BRIDGE] Error en EventChannel: $error');
        _logger.e(
          'GatewayNativeBridge: Error receiving native event',
          error: error,
        );
      },
    );
  }

  void stopListening() {
    _rawSubscription?.cancel();
    _rawSubscription = null;
  }

  Future<void> startService() async {
    try {
      await _activityControlChannel.invokeMethod<void>('startGatewayService');
      _logger.i('GatewayNativeBridge: Requested to start gateway service');
    } on PlatformException catch (e) {
      _logger.e(
        'GatewayNativeBridge: Failed to start gateway service',
        error: e,
      );
      rethrow;
    }
  }

  Future<void> stopService() async {
    try {
      await _activityControlChannel.invokeMethod<void>('stopGatewayService');
      _logger.i('GatewayNativeBridge: Requested to stop gateway service');
    } on PlatformException catch (e) {
      _logger.e(
        'GatewayNativeBridge: Failed to stop gateway service',
        error: e,
      );
      rethrow;
    }
  }

  Future<bool> isServiceRunning() async {
    try {
      final result = await _activityControlChannel.invokeMethod<bool>(
        'isGatewayServiceRunning',
      );
      return result ?? false;
    } on PlatformException catch (e) {
      _logger.e(
        'GatewayNativeBridge: Failed to check if gateway service is running',
        error: e,
      );
      return false;
    }
  }

  void dispose() {
    stopListening();
    _eventsController.close();
  }
}
