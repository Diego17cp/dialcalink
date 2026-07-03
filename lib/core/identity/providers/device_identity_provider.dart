import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/database/drift/app_database_provider.dart';
import 'package:dialcalink/core/database/drift/tables/devices_table.dart';
import 'package:dialcalink/core/identity/device_identity_service.dart';
import 'package:dialcalink/core/identity/device_identity_storage.dart';
import 'package:dialcalink/core/platform/device_info_service.dart';
import 'package:dialcalink/core/storage/providers/flutter_secure_storage_provider.dart';
import 'package:dialcalink/core/storage/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_identity_provider.g.dart';

@riverpod
DeviceInfoService deviceInfoService(Ref ref) => DeviceInfoService();

@riverpod
Future<DeviceIdentityStorage> deviceIdentityStorage(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  final secure = ref.watch(flutterSecureStorageProvider);
  return DeviceIdentityStorage(prefs, secure);
}

@riverpod
Future<DeviceIdentityService> deviceIdentityService(Ref ref) async {
  final storage = await ref.watch(deviceIdentityStorageProvider.future);
  final deviceInfo = ref.watch(deviceInfoServiceProvider);
  final database = ref.watch(appDatabaseProvider);
  return DeviceIdentityService(storage, deviceInfo, database);
}

@riverpod
Stream<DeviceRole?> localDeviceRole(Ref ref) async* {
  final service = await ref.watch(deviceIdentityServiceProvider.future);
  final identity = await service.readIdentity();
  yield identity?.role;
}

@riverpod
Future<LocalDeviceIdentity?> localDeviceIdentity(Ref ref) async {
  final service = await ref.watch(deviceIdentityServiceProvider.future);
  return service.readIdentity();
}
