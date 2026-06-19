import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  DeviceInfoService({DeviceInfoPlugin? plugin}) : _plugin = plugin ?? DeviceInfoPlugin();

  final DeviceInfoPlugin _plugin;

  Future<String> getDeviceModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _plugin.androidInfo;
      final manufacturer = androidInfo.manufacturer.trim() ?? 'Unknown Manufacturer';
      final model = androidInfo.model.trim() ?? 'Unknown Model';
      return '$manufacturer $model';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _plugin.iosInfo;
      return iosInfo.name;
    }
    return 'Unknown Device';
  }
}