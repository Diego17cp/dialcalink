import 'package:dialcalink/core/failures/pairing_failure.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/pairing/domain/entities/pairing_attempt.dart';
import 'package:dialcalink/features/pairing/domain/repositories/pairing_repository.dart';
import 'package:dialcalink/features/pairing/domain/services/pairing_connection_checker.dart';
import 'package:dialcalink/features/pairing/domain/value_objects/pairing_payload_codec.dart';

class PairingRepositoryImpl implements PairingRepository {
  PairingRepositoryImpl(this._connectionChecker);

  final PairingConnectionChecker _connectionChecker;

  @override
  PairingAttempt? attemptFromScannedRaw(String raw) {
    final decodeResult = PairingPayloadCodec.decode(raw);
    return switch (decodeResult) {
      PairingPayloadDecoded(payload: final payload) => PairingAttempt(
        payload: payload,
        status: PairingAttemptStatus.scanned,
      ),
      PairingPayloadInvalidFormat() => null,
      PairingPayloadMissingFields() => null,
    };
  }

  @override
  Future<Result<PairingAttempt>> verify(PairingAttempt attempt) async {
    final verifyingAttempt = PairingAttempt(
      payload: attempt.payload,
      status: PairingAttemptStatus.verifying,
    );
    final result = await _connectionChecker.verify(attempt.payload);

    return result.when(
      ok: (confirmed) {
        final updated = PairingAttempt(
          payload: verifyingAttempt.payload,
          status: confirmed
              ? PairingAttemptStatus.confirmed
              : PairingAttemptStatus.rejected,
          rejectionReason: confirmed ? null : 'The Gateway rejected the token.',
        );
        return Result.ok(updated);
      },
      failure: (failure) {
        final updated = PairingAttempt(
          payload: verifyingAttempt.payload,
          status: PairingAttemptStatus.rejected,
          rejectionReason: failure is PairingFailure
              ? failure.message
              : 'Error during connection verification: ${failure.message}',
        );
        return Result.ok(updated);
      },
    );
  }
}
