import 'package:dialcalink/core/failures/failure.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class ApkInstallerBridge {
  ApkInstallerBridge({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;
  static const _channel = MethodChannel(
    'com.dialcadev.dialcalink/apk_installer',
  );

  Future<bool> canRequestInstallPackages() async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'canRequestInstallPackages',
      );
      return result ?? false;
    } on PlatformException catch (e) {
      _logger.e('ApkInstallerBridge: error chequeando permisos', error: e);
      return false;
    }
  }

  Future<void> openInstallPermissionSettings() async {
    try {
      await _channel.invokeMethod('openInstallPermissionSettings');
    } on PlatformException catch (e) {
      _logger.e('ApkInstallerBridge: error abriendo ajustes', error: e);
    }
  }

  Future<Result<void>> installApk(String apkPath) async {
    try {
      final result = await _channel.invokeMethod<Map>('installApk', {
        'path': apkPath,
      });
      final success = result?['success'] as bool? ?? false;
      if (success) return Result.ok(null);
      return Result.failure(
        PlatformFailure(result?['error'] as String? ?? 'Error desconocido'),
      );
    } on PlatformException catch (e) {
      _logger.e('ApkInstallerBridge: error instalando APK', error: e);
      return Result.failure(PlatformFailure(e.message ?? 'Platform error'));
    }
  }
}
