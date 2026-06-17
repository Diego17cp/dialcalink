import 'package:drift/drift.dart';
import '../tables/devices_table.dart';
import '../app_database.dart';

part 'devices_dao.g.dart';

@DriftAccessor(tables: [Devices])
class DevicesDao extends DatabaseAccessor<AppDatabase> with _$DevicesDaoMixin {
  DevicesDao(super.db);

  Stream<List<Device>> watchLinkedDevices() {
    final query = select(devices)
      ..where((d) => d.pairingStatus.equalsValue(DevicePairingStatus.linked))
      ..orderBy([
        (d) => OrderingTerm(expression: d.lastSeenAt, mode: OrderingMode.desc),
      ]);
    return query.watch();
  }

  Stream<Device?> watchDeviceById(String id) {
    final query = select(devices)..where((d) => d.id.equals(id));
    return query.watchSingleOrNull();
  }

  Future<Device?> findById(String id) {
    final query = select(devices)..where((d) => d.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<void> insertDevice(DevicesCompanion entry) {
    return into(devices).insert(entry);
  }

  Future<void> updatePairingStatus(
    String deviceId,
    DevicePairingStatus newStatus,
  ) {
    return (update(devices)..where((d) => d.id.equals(deviceId))).write(
      DevicesCompanion(
        pairingStatus: Value(newStatus),
      ),
    );
  }

  Future<void> touchLastSeen(
    String deviceId, {
    String? ip,
    int? port,
  }) {
    return (update(devices)..where((d) => d.id.equals(deviceId))).write(
      DevicesCompanion(
        lastSeenAt: Value(DateTime.now()),
        lastKnownIp: ip != null ? Value(ip) : const Value.absent(),
        lastKnownPort: port != null ? Value(port) : const Value.absent(),
      ),
    );
  }

  Future<void> revokeDevice(String deviceId) {
    return updatePairingStatus(deviceId, DevicePairingStatus.revoked);
  }

  Future<int> deleteDevice(String deviceId) {
    return (delete(devices)..where((d) => d.id.equals(deviceId))).go();
  }

  Future<Device?> getLocalDevice(String localDeviceId) => findById(localDeviceId);
}
