import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/platform/device_info_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info_provider.g.dart';

@riverpod
DeviceInfoService deviceInfoService(Ref ref) => DeviceInfoService();
