import 'package:notidialca/core/database/drift/tables/devices_table.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/devices/domain/entities/device_entity.dart';

abstract class DeviceRepository {
  Stream<List<DeviceEntity>> watchLinkedDevices();
  Stream<DeviceEntity?> watchDeviceById(String id);
  Future<Result<DeviceEntity>> findById(String id);
  Future<Result<void>> insertDevice(DeviceEntity device);
  Future<Result<void>> upsertDevice(DeviceEntity device);
  Future<Result<void>> updatePairingStatus(
    String deviceId,
    DevicePairingStatus status,
  );
  Future<Result<void>> touchLastSeen(String deviceId, {String? ip, int? port});
  Future<Result<void>> revokeDevice(String deviceId);
  Future<Result<void>> deleteDevice(String deviceId);
}
