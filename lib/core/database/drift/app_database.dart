import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/calls_dao.dart';
import 'daos/devices_dao.dart';
import 'daos/sms_dao.dart';
import 'daos/sync_events_dao.dart';
import 'tables/call_logs_table.dart';
import 'tables/devices_table.dart';
import 'tables/sms_messages_table.dart';
import 'tables/sync_events_table.dart';

part 'app_database.g.dart';

const String _databaseName = 'notidialca';

@DriftDatabase(
  tables: [
    Devices,
    SmsMessages,
    CallLogs,
    SyncEvents,
  ],
  daos: [
    DevicesDao,
    SmsDao,
    CallsDao,
    SyncEventsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());
  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {

      },
      beforeOpen:(details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _databaseName,
      native: const DriftNativeOptions(
        shareAcrossIsolates: true
      )
    );
  } 
}