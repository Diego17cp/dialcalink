import 'package:drift/drift.dart';
import '../tables/call_logs_table.dart';
import '../app_database.dart';

part 'calls_dao.g.dart';

@DriftAccessor(tables: [CallLogs])
class CallsDao extends DatabaseAccessor<AppDatabase> with _$CallsDaoMixin {
  CallsDao(super.db);

  Stream<List<CallLog>> watchAllCalls() {
    final query = select(callLogs)
      ..orderBy([
        (t) => OrderingTerm(
            expression: t.startedAt,
            mode: OrderingMode.desc
        )
      ]);
    return query.watch();
  }

  Stream<List<CallLog>> watchCallsByPhoneNumber(String phoneNumber) {
    final query = select(callLogs)
      ..where((t) => t.phoneNumber.equals(phoneNumber))
      ..orderBy([
        (t) => OrderingTerm(
            expression: t.startedAt,
            mode: OrderingMode.desc
        )
      ]);
    return query.watch();
  }

  Future<void> insertCall(CallLogsCompanion entry) {
    return into(callLogs).insert(entry);
  }

  Future<void> upsertCall(CallLogsCompanion entry) {
    return into(callLogs).insertOnConflictUpdate(entry);
  }

  Future<void> markCallEnded(String callId, DateTime endedAt) {
    return (update(callLogs)..where((t) => t.id.equals(callId))).write(
      CallLogsCompanion(
        endedAt: Value(endedAt),
      ),
    );
  }

  Future<CallLog?> findById(String id) {
    final query = select(callLogs)..where((t) => t.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<CallLog?> findOpenCallByPhoneNumber(String phoneNumber) {
    final query = select(callLogs)
      ..where(
        (t) => t.phoneNumber.equals(phoneNumber) & t.endedAt.isNull(),
      )
      ..orderBy([
        (t) => OrderingTerm(
              expression: t.startedAt,
              mode: OrderingMode.desc,
            ),
      ])
      ..limit(1);
    return query.getSingleOrNull();
  }

  Future<int> countByDateAndId(DateTime date, String id) {
    final query = select(callLogs)
      ..where((t) =>
          t.startedAt.isBiggerOrEqualValue(date) &
          t.id.equals(id));
    return query.get().then((rows) => rows.length);
  }
}