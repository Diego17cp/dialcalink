import 'package:dialcalink/core/database/drift/tables/devices_table.dart';
import 'package:dialcalink/core/failures/pairing_failure.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/devices/domain/entities/device_entity.dart';
import 'package:dialcalink/features/devices/domain/repositories/device_repository.dart';
import 'package:dialcalink/features/pairing/domain/entities/pairing_attempt.dart';
import 'package:dialcalink/features/pairing/domain/repositories/pairing_repository.dart';

const Duration kPairingTokenMaxAge = Duration(minutes: 5);

// Client

class ConfirmPairingUseCase {
  ConfirmPairingUseCase(
    this._pairingRepository,
    this._deviceRepository, {
    this.onPairingConfirmed,
  });

  final PairingRepository _pairingRepository;
  final DeviceRepository _deviceRepository;
  final Future<void> Function(String linkedDeviceId)? onPairingConfirmed;

  Future<Result<DeviceEntity>> call(PairingAttempt attempt) async {
    final age = DateTime.now().difference(attempt.payload.generatedAt);
    if (age > kPairingTokenMaxAge) {
      return Result.failure(
        const PairingTokenExpiredFailure(
          'El token de emparejamiento ha expirado. Por favor, genere uno nuevo e intente nuevamente.',
        ),
      );
    }
    final verifyResult = await _pairingRepository.verify(attempt);
    if (verifyResult.isFailure) {
      return Result.failure(verifyResult.failureOrNull!);
    }
    final verifiedAttempt = verifyResult.valueOrNull!;
    if (!verifiedAttempt.isConfirmed) {
      return Result.failure(
        PairingRejectedByGatewayFailure(
          verifiedAttempt.rejectionReason ??
              'El intento de emparejamiento fue rechazado por el Gateway.',
        ),
      );
    }
    final device = DeviceEntity(
      id: verifiedAttempt.payload.deviceId,
      deviceName: verifiedAttempt.payload.deviceName,
      role: DeviceRole.gateway,
      pairingStatus: DevicePairingStatus.linked,
      lastKnownIp: verifiedAttempt.payload.ip,
      lastKnownPort: verifiedAttempt.payload.port,
      lastSeenAt: DateTime.now(),
    );
    final saveResult = await _deviceRepository.upsertDevice(device);
    if (saveResult.isFailure) {
      return Result.failure(saveResult.failureOrNull!);
    }
    await onPairingConfirmed?.call(device.id);
    return Result.ok(device);
  }
}
