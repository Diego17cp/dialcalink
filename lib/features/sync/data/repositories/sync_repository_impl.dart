import 'package:dialcalink/core/database/drift/daos/sync_events_dao.dart';
import 'package:dialcalink/core/failures/failure.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/sync/data/mappers/sync_event_mapper.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';
import 'package:dialcalink/features/sync/domain/repositories/sync_repository.dart';

class SyncRepositoryImpl implements SyncRepository {
  SyncRepositoryImpl(this._dao);
  final SyncEventsDao _dao;

  @override
  Stream<List<SyncEventEntity>> watchPendingEvents() => _dao
      .watchPendingEvents()
      .map((rows) => rows.map(SyncEventMapper.toEntity).toList());
  
  @override
  Future<Result<List<SyncEventEntity>>> getPendingEvents() async {
    try {
      final rows = await _dao.getPendingEvents();
      return Result.ok(rows.map(SyncEventMapper.toEntity).toList());
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error obteniendo eventos pendientes', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> enqueueEvent(SyncEventEntity event) async {
    try {
      await _dao.enqueueEvent(SyncEventMapper.toCompanion(event));
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        IntegrityFailure('Error encolando evento ${event.id}', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> markAsSynced(String id) async {
    try {
      await _dao.markAsSynced(id);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error marcando evento $id como sincronizado', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> markManyAsSynced(List<String> ids) async {
    try {
      await _dao.markManyAsSynced(ids);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error marcando eventos ${ids.join(', ')} como sincronizados', cause: e),
      );
    }
  }

  @override
  Future<Result<int>> purgeSyncedBefore(DateTime cutoff) async {
    try {
      final count = await _dao.purgeSyncedBefore(cutoff);
      return Result.ok(count);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error purgando eventos sincronizados antes de $cutoff', cause: e),
      );
    }
  }
}