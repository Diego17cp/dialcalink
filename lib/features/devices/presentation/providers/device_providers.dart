import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/features/devices/domain/entities/device_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dialcalink/core/database/drift/app_database_provider.dart';
import 'package:dialcalink/features/devices/data/repositories/device_repository_impl.dart';
import 'package:dialcalink/features/devices/domain/repositories/device_repository.dart';

part 'device_providers.g.dart';

@riverpod
DeviceRepository deviceRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DeviceRepositoryImpl(db.devicesDao);
}

@riverpod
Stream<List<DeviceEntity>> linkedDevices(Ref ref) {
  final repo = ref.watch(deviceRepositoryProvider);
  return repo.watchLinkedDevices();
}

@riverpod
Stream<DeviceEntity?> deviceById(Ref ref, String id) {
  final repo = ref.watch(deviceRepositoryProvider);
  return repo.watchDeviceById(id);
}
