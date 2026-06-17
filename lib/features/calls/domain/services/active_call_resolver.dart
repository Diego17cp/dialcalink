import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/calls/domain/entities/call_log_entity.dart';
import 'package:notidialca/features/calls/domain/repositories/call_repository.dart';
import 'package:uuid/uuid.dart';

class ActiveCallResolver {
  ActiveCallResolver(this._callRepository);

  final CallRepository _callRepository;
  final Uuid _uuid = const Uuid();

  Future<Result<ActiveCallLookup>> resolveIdFor(String phoneNumber) async {
    final openCallResult = await _callRepository.findOpenCallByPhoneNumber(phoneNumber);
    if (openCallResult.isFailure) {
      return Result.failure(openCallResult.failureOrNull!);
    }
    final existing = openCallResult.valueOrNull;
    if (existing != null) {
      return Result.ok(ActiveCallLookup(id: existing.id, existing: existing));
    }
    return Result.ok(ActiveCallLookup(id: _uuid.v4(), existing: null));
  }
}

class ActiveCallLookup {
  const ActiveCallLookup({
    required this.id,
    required this.existing,
  });

  final String id;
  final CallLogEntity? existing;

  bool get isExisting => existing != null;
}