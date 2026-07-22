import 'package:drift/drift.dart';
import '../tables/sms_messages_table.dart';
import '../app_database.dart';

part 'sms_dao.g.dart';

@DriftAccessor(tables: [SmsMessages])
class SmsDao extends DatabaseAccessor<AppDatabase> with _$SmsDaoMixin {
  SmsDao(super.db);

  Stream<List<SmsMessage>> watchAllMessages() {
    final query = select(smsMessages)
      ..orderBy([
        (t) => OrderingTerm(
            expression: t.receivedAt,
            mode: OrderingMode.desc
        )
      ]);
    return query.watch();
  }

  Stream<List<SmsMessage>> watchMessagesByPhoneNumber(String phoneNumber) {
    final query = select(smsMessages)
      ..where((t) => t.phoneNumber.equals(phoneNumber))
      ..orderBy([
        (t) => OrderingTerm(
            expression: t.receivedAt,
            mode: OrderingMode.desc
        )
      ]);
    return query.watch();
  }

  Stream<int> watchUnreadCount() {
    final query = selectOnly(smsMessages)
      ..addColumns([smsMessages.id.count()])
      ..where(smsMessages.isRead.equals(false));
    return query
      .map((row) => row.read(smsMessages.id.count()) ?? 0)
      .watchSingle();
  }

  Future<void> insertMessage(SmsMessagesCompanion entry) {
    return into(smsMessages).insert(entry);
  }

  Future<void> upsertMessage(SmsMessagesCompanion entry) {
    return into(smsMessages).insertOnConflictUpdate(entry);
  }

  Future<void> markAsRead(String messageId) {
    return (update(smsMessages)..where((t) => t.id.equals(messageId))).write(
      const SmsMessagesCompanion(
        isRead: Value(true),
      ),
    );
  }
  Future<void> markAllAsReadByPhoneNumber(String phoneNumber) {
    return (update(smsMessages)..where((t) => t.phoneNumber.equals(phoneNumber))).write(
      const SmsMessagesCompanion(
        isRead: Value(true),
      ),
    );
  }

  Future<SmsMessage?> findById(String id) {
    final query = select(smsMessages)..where((t) => t.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<int> countByDateAndId(DateTime date, String id) {
    final query = select(smsMessages)
      ..where((t) =>
          t.receivedAt.isBiggerOrEqualValue(date) &
          t.sourceDeviceId.equals(id));
    return query.get().then((rows) => rows.length);
  }

  Stream<int> watchCountByDateAndId(DateTime date, String id) {
    final query = selectOnly(smsMessages)
      ..addColumns([smsMessages.id.count()])
      ..where(
        smsMessages.receivedAt.isBiggerOrEqualValue(date) &
        smsMessages.sourceDeviceId.equals(id),
      );
    return query.map((row) => row.read(smsMessages.id.count()) ?? 0).watchSingle();
  }

  Future<int> deleteMessagesByPhoneNumber(String phoneNumber) {
    return (delete(smsMessages)..where((t) => t.phoneNumber.equals(phoneNumber))).go();
  }
}