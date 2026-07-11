import 'package:flutter/services.dart';
import 'package:logger/web.dart';

class ClientNativeBridge {
  ClientNativeBridge({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  static const _activityControlChannel = MethodChannel(
    'com.dialcadev.dialcalink/gateway_service_control',
  );

  Future<void> startClientService() async {
    try {
      await _activityControlChannel
          .invokeListMethod<void>('startClientService')
          .timeout(const Duration(seconds: 5));
      _logger.i('ClientNativeBridge: startClientService invocado');
    } on PlatformException catch (e) {
      _logger.e('ClientNativeBridge: startClientService error: $e');
      rethrow;
    }
  }

  Future<void> stopClientService() async {
    try {
      await _activityControlChannel
          .invokeMethod<void>('stopClientService')
          .timeout(const Duration(seconds: 5));
      _logger.i('ClientNativeBridge: stopClientService invocado');
    } on PlatformException catch (e) {
      _logger.e('ClientNativeBridge: stopClientService error: $e');
      rethrow;
    }
  }

  Future<bool> isClientServiceRunning() async {
    try {
      final result = await _activityControlChannel
          .invokeMethod<bool>('isClientServiceRunning')
          .timeout(const Duration(seconds: 5));
      return result ?? false;
    } on PlatformException catch (e) {
      _logger.e('ClientNativeBridge: isClientServiceRunning error: $e');
      return false;
    }
  }
}
