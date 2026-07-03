import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/database/drift/app_database_provider.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/sync/data/repositories/sync_repository_impl.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';
import 'package:dialcalink/features/sync/domain/repositories/sync_repository.dart';
import 'package:dialcalink/features/sync/domain/usecases/get_pending_sync_events_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_providers.g.dart';

@riverpod
SyncRepository syncRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SyncRepositoryImpl(db.syncEventsDao);
}

// Gateway
@riverpod
GetPendingSyncEventsUseCase getPendingSyncEventsUseCase(Ref ref) {
  return GetPendingSyncEventsUseCase(ref.watch(syncRepositoryProvider));
}

@riverpod
Stream<List<SyncEventEntity>> pendingSyncEvents(Ref ref) {
  final repo = ref.watch(syncRepositoryProvider);
  return repo.watchPendingEvents();
}

@riverpod
Future<Result<void>> markSyncEventAsSynced(Ref ref, String eventId) {
  final repo = ref.watch(syncRepositoryProvider);
  return repo.markAsSynced(eventId);
}
