import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/sync/domain/entities/sync_event_entity.dart';
import 'package:notidialca/features/sync/domain/repositories/sync_repository.dart';

// Gateway excl.

class GetPendingSyncEventsUseCase {
  GetPendingSyncEventsUseCase(this._syncRepository);

  final SyncRepository _syncRepository;

  Future<Result<List<SyncEventEntity>>> call() {
    return _syncRepository.getPendingEvents();
  }
}