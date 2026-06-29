import 'package:notidialca/core/database/drift/tables/devices_table.dart' show DeviceRole;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _kDeviceRole = 'identity.device_role';
const String _kDeviceName = 'identity.device_name';
const String _kServiceStartedAt = 'identity.service_started_at';
const String _kDeviceId = 'identity.device_id';

class DeviceIdentityStorage {
  DeviceIdentityStorage(this._prefs, this._secure);

  final SharedPreferences _prefs;
  final FlutterSecureStorage _secure;

  Future<String?> readDeviceId() async => _secure.read(key: _kDeviceId);
  Future<void> writeDeviceId(String id) async => _secure.write(key: _kDeviceId, value: id);

  DeviceRole? readRole() {
    final raw = _prefs.getString(_kDeviceRole);
    if (raw == null) return null;
    return DeviceRole.values.firstWhere(
      (r) => r.name == raw,
      orElse: () => DeviceRole.client,
    );
  }
  Future<void> writeRole(DeviceRole role) async => _prefs.setString(_kDeviceRole, role.name);
  Future<void> clearRole() async => _prefs.remove(_kDeviceRole);

  String? readDeviceName() => _prefs.getString(_kDeviceName);
  Future<void> writeDeviceName(String name) async => _prefs.setString(_kDeviceName, name);
  
  Future<bool> isInitialized() async {
    final id = await readDeviceId();
    final role = readRole();
    final name = readDeviceName();
    return id != null && role != null && name != null;
  }

  DateTime? readServiceStartedAt() {
    final raw = _prefs.getInt(_kServiceStartedAt);
    if (raw == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(raw);
  }

  Future<void> writeServiceStartedAt(DateTime startedAt) async => _prefs.setInt(_kServiceStartedAt, startedAt.millisecondsSinceEpoch);

  Future<void> clearServiceStartedAt() async => _prefs.remove(_kServiceStartedAt);

  Future<DateTime?> readServiceStartedAtAsync() async {
    await _prefs.reload();
    return readServiceStartedAt();
  }
}