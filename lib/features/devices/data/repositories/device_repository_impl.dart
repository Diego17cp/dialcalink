import 'package:notidialca/core/database/drift/daos/devices_dao.dart';
import 'package:notidialca/core/database/drift/tables/devices_table.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/core/failures/failure.dart';
import 'package:notidialca/features/devices/data/mappers/device_mapper.dart';
import 'package:notidialca/features/devices/domain/entities/device_entity.dart';
import 'package:notidialca/features/devices/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl(this._dao);
  final DevicesDao _dao;

  @override
  Stream<List<DeviceEntity>> watchLinkedDevices() => _dao
      .watchLinkedDevices()
      .map((rows) => rows.map(DeviceMapper.toEntity).toList());

  @override
  Stream<DeviceEntity?> watchDeviceById(String id) => _dao
      .watchDeviceById(id)
      .map((row) => row != null ? DeviceMapper.toEntity(row) : null);

  @override
  Future<Result<DeviceEntity>> findById(String id) async {
    try {
      final row = await _dao.findById(id);
      if (row == null) {
        return Result.failure(
          NotFoundFailure('No existe un dispositivo con id $id'),
        );
      }
      return Result.ok(DeviceMapper.toEntity(row));
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error buscando dispositivo $id', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> insertDevice(DeviceEntity entity) async {
    try {
      await _dao.insertDevice(DeviceMapper.toCompanion(entity));
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        IntegrityFailure('Error insertando dispositivo ${entity.id}', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> updatePairingStatus(
    String deviceId,
    DevicePairingStatus status,
  ) async {
    try {
      await _dao.updatePairingStatus(deviceId, status);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          'Error actualizando estado de emparejamiento para dispositivo $deviceId',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> touchLastSeen(
    String deviceId, {
    String? ip,
    int? port,
  }) async {
    try {
      await _dao.touchLastSeen(deviceId, ip: ip, port: port);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          'Error actualizando última conexión para dispositivo $deviceId',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> revokeDevice(String deviceId) async {
    try {
      await _dao.revokeDevice(deviceId);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error revocando dispositivo $deviceId', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> deleteDevice(String deviceId) async {
    try {
      final rowsAffected = await _dao.deleteDevice(deviceId);
      if (rowsAffected == 0) {
        return Result.failure(
          NotFoundFailure('No existe un dispositivo con id $deviceId'),
        );
      }
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error eliminando dispositivo $deviceId', cause: e),
      );
    }
  }
}
