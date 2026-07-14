import 'package:dialcalink/core/failures/failure.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:flutter/services.dart';

class GatewayControlBridge {
  static const _channel = MethodChannel('com.dialcadev.dialcalink/gateway_control');

  Future<Result<void>> sendSms(String to, String content) async {
    try {
      final result = await _channel.invokeMethod<Map>('sendSms', {'to': to, 'content': content});
      final success = result?['success'] as bool? ?? false;
      if (success) return Result.ok(null);
      return Result.failure(IntegrityFailure(result?['error'] as String? ?? 'Unknown error'));
    } on PlatformException catch (e) {
      return Result.failure(UnknownFailure(e.message ?? 'Platform error'));
    }
  }
}