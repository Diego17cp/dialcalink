import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dialcalink/features/pairing/domain/value_objects/pairing_payload.dart';

part 'pairing_attempt.freezed.dart';

@freezed
class PairingAttempt with _$PairingAttempt {
  const factory PairingAttempt({
    required PairingPayload payload,
    required PairingAttemptStatus status,
    String? rejectionReason,
  }) = _PairingAttempt;

  const PairingAttempt._();

  bool get isVerifying => status == PairingAttemptStatus.verifying;
  bool get isConfirmed => status == PairingAttemptStatus.confirmed;
  bool get isRejected => status == PairingAttemptStatus.rejected;
}

enum PairingAttemptStatus {
  scanned,
  verifying,
  confirmed,
  rejected,
}