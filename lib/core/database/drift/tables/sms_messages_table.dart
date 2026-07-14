import 'package:drift/drift.dart';
import 'devices_table.dart';

enum SmsDirection { incoming, outgoing }

class SmsMessages extends Table {
  TextColumn get id => text()();
  TextColumn get phoneNumber => text().named('phone_number')();
  TextColumn get contactName => text().named('contact_name').nullable()();
  TextColumn get content => text()();
  DateTimeColumn get receivedAt => dateTime().named('received_at')();
  TextColumn get sourceDeviceId =>
      text().named('source_device_id').references(Devices, #id)();
  BoolColumn get isRead =>
      boolean().named('is_read').withDefault(const Constant(false))();
  TextColumn get direction => textEnum<SmsDirection>()
      .named('direction')
      .withDefault(const Constant('incoming'))();
  @override
  Set<Column> get primaryKey => {id};
}
