import 'package:drift/drift.dart';

import '../../../../core/database/drift/app_database.dart';
import '../../domain/entities/device_entity.dart';

class DeviceMapper {
  const DeviceMapper._();

  static DeviceEntity toEntity(Device row) {
    return DeviceEntity(
      id: row.id,
      deviceName: row.deviceName,
      role: row.role,
      pairingStatus: row.pairingStatus,
      lastKnownIp: row.lastKnownIp,
      lastKnownPort: row.lastKnownPort,
      lastSeenAt: row.lastSeenAt,
    );
  }

  static DevicesCompanion toCompanion(DeviceEntity entity) {
    return DevicesCompanion(
      id: Value(entity.id),
      deviceName: Value(entity.deviceName),
      role: Value(entity.role),
      pairingStatus: Value(entity.pairingStatus),
      lastKnownIp: entity.lastKnownIp == null
        ? const Value.absent()
        : Value(entity.lastKnownIp),
      lastKnownPort: entity.lastKnownPort == null
        ? const Value.absent()
        : Value(entity.lastKnownPort),
      lastSeenAt: entity.lastSeenAt == null
        ? const Value.absent()
        : Value(entity.lastSeenAt),
    );
  }
}