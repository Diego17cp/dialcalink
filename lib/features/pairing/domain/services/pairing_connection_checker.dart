import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/pairing/domain/value_objects/pairing_payload.dart';

abstract class PairingConnectionChecker {
  Future<Result<bool>> verify(PairingPayload payload);
}