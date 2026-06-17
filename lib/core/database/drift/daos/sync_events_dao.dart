import 'package:drift/drift.dart';

import '../tables/sync_events_table.dart';
import '../app_database.dart';

part 'sync_events_dao.g.dart';

@DriftAccessor(tables: [SyncEvents])
class SyncEventsDao extends DatabaseAccessor<AppDatabase> with _$SyncEventsDaoMixin {
  SyncEventsDao(super.db);
  Stream<List<SyncEvent>> watchPendingEvents() {
    final query = select(syncEvents)
      ..where((e) => e.synced.equals(false))
      ..orderBy([
        (e) => OrderingTerm(
            expression: e.createdAt,
            mode: OrderingMode.asc
        )
      ]);
    return query.watch();
  }
  Future<List<SyncEvent>> getPendingEvents() {
    final query = select(syncEvents)
      ..where((e) => e.synced.equals(false))
      ..orderBy([
        (e) => OrderingTerm(
            expression: e.createdAt,
            mode: OrderingMode.asc
        )
      ]);
    return query.get();
  }
  Future<void> enqueueEvent(SyncEventsCompanion entry) {
    return into(syncEvents).insert(entry);
  }
  Future<void> markAsSynced(String eventId) {
    return (update(syncEvents)..where((e) => e.id.equals(eventId))).write(
      SyncEventsCompanion(
        synced: const Value(true),
      ),
    );
  }
  Future<void> markManyAsSynced(List<String> eventIds) {
    return db.transaction(() async {
      for (final id in eventIds) {
        await markAsSynced(id);
      }
    });
  }
  Future<int> purgeSyncedBefore(DateTime cutoff) {
    return (delete(syncEvents)
      ..where((e) => e.synced.equals(true) & e.createdAt.isSmallerThanValue(cutoff))
    ).go();
  }
}
