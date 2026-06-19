import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notidialca/core/failures/pairing_failure.dart';
import 'package:notidialca/features/devices/domain/entities/device_entity.dart';
import 'package:notidialca/features/pairing/domain/entities/pairing_attempt.dart';

part 'client_pairing_state.freezed.dart';

@freezed
class ClientPairingState with _$ClientPairingState {
  const factory ClientPairingState({
    @Default(ClientPairingPhase.scanning) ClientPairingPhase phase,
    PairingAttempt? attempt,
    DeviceEntity? linkedDevice,
    PairingFailure? failure,
  }) = _ClientPairingState;
}

enum ClientPairingPhase {
  scanning,
  invalidQr,
  verifying,
  linked,
  failed,
}