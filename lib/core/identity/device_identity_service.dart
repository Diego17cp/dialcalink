import 'package:notidialca/core/database/drift/app_database.dart';
import 'package:notidialca/core/database/drift/tables/devices_table.dart'
    show DeviceRole;
import 'package:notidialca/core/platform/device_info_service.dart';
import 'package:notidialca/core/identity/device_identity_storage.dart';
import 'package:uuid/uuid.dart';

class LocalDeviceIdentity {
  const LocalDeviceIdentity({
    required this.id,
    required this.name,
    required this.role,
  });

  final String id;
  final String name;
  final DeviceRole role;
}

class DeviceIdentityService {
  DeviceIdentityService(this._storage, this._deviceInfoService, this._database);

  final DeviceIdentityStorage _storage;
  final DeviceInfoService _deviceInfoService;
  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Future<void> ensureBootstrapped() async {
    String? id = await _storage.readDeviceId();
    if (id == null) {
      id = _uuid.v4();
      await _storage.writeDeviceId(id);
    }
    if (_storage.readDeviceName() == null) {
      final deviceName = await _deviceInfoService.getDeviceModel();
      await _storage.writeDeviceName(deviceName);
    }
  }

  Future<LocalDeviceIdentity?> readIdentity() async {
    final id = await _storage.readDeviceId();
    final name = _storage.readDeviceName();
    final role = _storage.readRole();
    if (id == null || name == null || role == null) {
      return null;
    }
    return LocalDeviceIdentity(id: id, name: name, role: role);
  }

  Future<void> setRole(DeviceRole role) async {
    await _storage.writeRole(role);

    final id = await _storage.readDeviceId();
    final name = _storage.readDeviceName();
    if (id == null || name == null) return;

    await _database.devicesDao.upsertLocalDevice(
      id: id,
      name: name,
      role: role,
    );
  }

  Future<void> clearRole() async => await _storage.clearRole();
}
