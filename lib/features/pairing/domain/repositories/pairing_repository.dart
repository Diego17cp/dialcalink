import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/pairing/domain/entities/pairing_attempt.dart';

abstract class PairingRepository {
  PairingAttempt? attemptFromScannedRaw(String raw);
  Future<Result<PairingAttempt>> verify(PairingAttempt attempt);
}