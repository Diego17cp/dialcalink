import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';

abstract class SyncRepository {
  Stream<List<SyncEventEntity>> watchPendingEvents();
  Future<Result<List<SyncEventEntity>>> getPendingEvents();
  Future<Result<void>> enqueueEvent(SyncEventEntity event);
  Future<Result<void>> markAsSyncedByEntity(String id);
  Future<Result<void>> markAsSynced(String id);
  Future<Result<void>> markManyAsSynced(List<String> ids);
  Future<Result<int>> purgeSyncedBefore(DateTime cutoff);
}