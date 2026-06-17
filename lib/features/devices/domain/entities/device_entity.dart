import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/drift/tables/devices_table.dart' show DeviceRole, DevicePairingStatus;

part 'device_entity.freezed.dart';

@freezed
class DeviceEntity with _$DeviceEntity {
  const factory DeviceEntity({
    required String id,
    required String deviceName,
    required DeviceRole role,
    required DevicePairingStatus pairingStatus,
    String? lastKnownIp,
    int? lastKnownPort,
    DateTime? lastSeenAt,
  }) = _DeviceEntity;

  const DeviceEntity._();

  bool get isLinked => pairingStatus == DevicePairingStatus.linked;
}