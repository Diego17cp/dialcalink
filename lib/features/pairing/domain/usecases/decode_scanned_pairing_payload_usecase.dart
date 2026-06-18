import 'package:notidialca/features/pairing/domain/entities/pairing_attempt.dart';
import 'package:notidialca/features/pairing/domain/repositories/pairing_repository.dart';

// Client
class DecodeScannedPairingPayloadUseCase {
  DecodeScannedPairingPayloadUseCase(this._pairingRepository);

  final PairingRepository _pairingRepository;

  PairingAttempt? call(String raw) {
    return _pairingRepository.attemptFromScannedRaw(raw);
  }
}