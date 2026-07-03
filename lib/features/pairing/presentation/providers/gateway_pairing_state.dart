import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dialcalink/core/failures/pairing_failure.dart';
import 'package:dialcalink/features/pairing/domain/value_objects/pairing_payload.dart';

part 'gateway_pairing_state.freezed.dart';

@freezed
class GatewayPairingState with _$GatewayPairingState {
  const factory GatewayPairingState({
    @Default(GatewayPairingPhase.idle) GatewayPairingPhase phase,
    PairingPayload? payload,
    PairingFailure? failure,
  }) = _GatewayPairingState;
}

enum GatewayPairingPhase {
  idle,
  generating,
  showingQr,
  awaitingManualIp,
  error,
}