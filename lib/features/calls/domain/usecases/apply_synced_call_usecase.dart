import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/calls/domain/entities/call_log_entity.dart';
import 'package:dialcalink/features/calls/domain/repositories/call_repository.dart';

// Client excl.

class ApplySyncedCallUseCase {
  ApplySyncedCallUseCase(this._callsRepository);
  final CallRepository _callsRepository;
  Future<Result<void>> call(CallLogEntity call) {
    return _callsRepository.upsertCall(call);
  }
}