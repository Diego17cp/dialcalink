import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/calls/domain/entities/call_log_entity.dart';
import 'package:notidialca/features/calls/domain/repositories/call_repository.dart';

// Client excl.

class ApplySyncedCallUseCase {
  ApplySyncedCallUseCase(this._callsRepository);
  final CallRepository _callsRepository;
  Future<Result<void>> call(CallLogEntity call) {
    return _callsRepository.upsertCall(call);
  }
}