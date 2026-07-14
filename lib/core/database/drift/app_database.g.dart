// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceNameMeta = const VerificationMeta(
    'deviceName',
  );
  @override
  late final GeneratedColumn<String> deviceName = GeneratedColumn<String>(
    'device_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DeviceRole, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DeviceRole>($DevicesTable.$converterrole);
  @override
  late final GeneratedColumnWithTypeConverter<DevicePairingStatus, String>
  pairingStatus = GeneratedColumn<String>(
    'pairing_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(DevicePairingStatus.pending.name),
  ).withConverter<DevicePairingStatus>($DevicesTable.$converterpairingStatus);
  static const VerificationMeta _lastKnownIpMeta = const VerificationMeta(
    'lastKnownIp',
  );
  @override
  late final GeneratedColumn<String> lastKnownIp = GeneratedColumn<String>(
    'last_known_ip',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastKnownPortMeta = const VerificationMeta(
    'lastKnownPort',
  );
  @override
  late final GeneratedColumn<int> lastKnownPort = GeneratedColumn<int>(
    'last_known_port',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
    'last_seen_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deviceName,
    role,
    pairingStatus,
    lastKnownIp,
    lastKnownPort,
    createdAt,
    lastSeenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Device> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('device_name')) {
      context.handle(
        _deviceNameMeta,
        deviceName.isAcceptableOrUnknown(data['device_name']!, _deviceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceNameMeta);
    }
    if (data.containsKey('last_known_ip')) {
      context.handle(
        _lastKnownIpMeta,
        lastKnownIp.isAcceptableOrUnknown(
          data['last_known_ip']!,
          _lastKnownIpMeta,
        ),
      );
    }
    if (data.containsKey('last_known_port')) {
      context.handle(
        _lastKnownPortMeta,
        lastKnownPort.isAcceptableOrUnknown(
          data['last_known_port']!,
          _lastKnownPortMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      deviceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_name'],
      )!,
      role: $DevicesTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
      pairingStatus: $DevicesTable.$converterpairingStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}pairing_status'],
        )!,
      ),
      lastKnownIp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_known_ip'],
      ),
      lastKnownPort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_known_port'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen_at'],
      ),
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DeviceRole, String, String> $converterrole =
      const EnumNameConverter<DeviceRole>(DeviceRole.values);
  static JsonTypeConverter2<DevicePairingStatus, String, String>
  $converterpairingStatus = const EnumNameConverter<DevicePairingStatus>(
    DevicePairingStatus.values,
  );
}

class Device extends DataClass implements Insertable<Device> {
  final String id;
  final String deviceName;
  final DeviceRole role;
  final DevicePairingStatus pairingStatus;
  final String? lastKnownIp;
  final int? lastKnownPort;
  final DateTime createdAt;
  final DateTime? lastSeenAt;
  const Device({
    required this.id,
    required this.deviceName,
    required this.role,
    required this.pairingStatus,
    this.lastKnownIp,
    this.lastKnownPort,
    required this.createdAt,
    this.lastSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['device_name'] = Variable<String>(deviceName);
    {
      map['role'] = Variable<String>($DevicesTable.$converterrole.toSql(role));
    }
    {
      map['pairing_status'] = Variable<String>(
        $DevicesTable.$converterpairingStatus.toSql(pairingStatus),
      );
    }
    if (!nullToAbsent || lastKnownIp != null) {
      map['last_known_ip'] = Variable<String>(lastKnownIp);
    }
    if (!nullToAbsent || lastKnownPort != null) {
      map['last_known_port'] = Variable<int>(lastKnownPort);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    }
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      deviceName: Value(deviceName),
      role: Value(role),
      pairingStatus: Value(pairingStatus),
      lastKnownIp: lastKnownIp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastKnownIp),
      lastKnownPort: lastKnownPort == null && nullToAbsent
          ? const Value.absent()
          : Value(lastKnownPort),
      createdAt: Value(createdAt),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
    );
  }

  factory Device.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<String>(json['id']),
      deviceName: serializer.fromJson<String>(json['deviceName']),
      role: $DevicesTable.$converterrole.fromJson(
        serializer.fromJson<String>(json['role']),
      ),
      pairingStatus: $DevicesTable.$converterpairingStatus.fromJson(
        serializer.fromJson<String>(json['pairingStatus']),
      ),
      lastKnownIp: serializer.fromJson<String?>(json['lastKnownIp']),
      lastKnownPort: serializer.fromJson<int?>(json['lastKnownPort']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastSeenAt: serializer.fromJson<DateTime?>(json['lastSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deviceName': serializer.toJson<String>(deviceName),
      'role': serializer.toJson<String>(
        $DevicesTable.$converterrole.toJson(role),
      ),
      'pairingStatus': serializer.toJson<String>(
        $DevicesTable.$converterpairingStatus.toJson(pairingStatus),
      ),
      'lastKnownIp': serializer.toJson<String?>(lastKnownIp),
      'lastKnownPort': serializer.toJson<int?>(lastKnownPort),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastSeenAt': serializer.toJson<DateTime?>(lastSeenAt),
    };
  }

  Device copyWith({
    String? id,
    String? deviceName,
    DeviceRole? role,
    DevicePairingStatus? pairingStatus,
    Value<String?> lastKnownIp = const Value.absent(),
    Value<int?> lastKnownPort = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> lastSeenAt = const Value.absent(),
  }) => Device(
    id: id ?? this.id,
    deviceName: deviceName ?? this.deviceName,
    role: role ?? this.role,
    pairingStatus: pairingStatus ?? this.pairingStatus,
    lastKnownIp: lastKnownIp.present ? lastKnownIp.value : this.lastKnownIp,
    lastKnownPort: lastKnownPort.present
        ? lastKnownPort.value
        : this.lastKnownPort,
    createdAt: createdAt ?? this.createdAt,
    lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
  );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      id: data.id.present ? data.id.value : this.id,
      deviceName: data.deviceName.present
          ? data.deviceName.value
          : this.deviceName,
      role: data.role.present ? data.role.value : this.role,
      pairingStatus: data.pairingStatus.present
          ? data.pairingStatus.value
          : this.pairingStatus,
      lastKnownIp: data.lastKnownIp.present
          ? data.lastKnownIp.value
          : this.lastKnownIp,
      lastKnownPort: data.lastKnownPort.present
          ? data.lastKnownPort.value
          : this.lastKnownPort,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('deviceName: $deviceName, ')
          ..write('role: $role, ')
          ..write('pairingStatus: $pairingStatus, ')
          ..write('lastKnownIp: $lastKnownIp, ')
          ..write('lastKnownPort: $lastKnownPort, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deviceName,
    role,
    pairingStatus,
    lastKnownIp,
    lastKnownPort,
    createdAt,
    lastSeenAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.deviceName == this.deviceName &&
          other.role == this.role &&
          other.pairingStatus == this.pairingStatus &&
          other.lastKnownIp == this.lastKnownIp &&
          other.lastKnownPort == this.lastKnownPort &&
          other.createdAt == this.createdAt &&
          other.lastSeenAt == this.lastSeenAt);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<String> id;
  final Value<String> deviceName;
  final Value<DeviceRole> role;
  final Value<DevicePairingStatus> pairingStatus;
  final Value<String?> lastKnownIp;
  final Value<int?> lastKnownPort;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastSeenAt;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.role = const Value.absent(),
    this.pairingStatus = const Value.absent(),
    this.lastKnownIp = const Value.absent(),
    this.lastKnownPort = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    required String deviceName,
    required DeviceRole role,
    this.pairingStatus = const Value.absent(),
    this.lastKnownIp = const Value.absent(),
    this.lastKnownPort = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       deviceName = Value(deviceName),
       role = Value(role);
  static Insertable<Device> custom({
    Expression<String>? id,
    Expression<String>? deviceName,
    Expression<String>? role,
    Expression<String>? pairingStatus,
    Expression<String>? lastKnownIp,
    Expression<int>? lastKnownPort,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceName != null) 'device_name': deviceName,
      if (role != null) 'role': role,
      if (pairingStatus != null) 'pairing_status': pairingStatus,
      if (lastKnownIp != null) 'last_known_ip': lastKnownIp,
      if (lastKnownPort != null) 'last_known_port': lastKnownPort,
      if (createdAt != null) 'created_at': createdAt,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith({
    Value<String>? id,
    Value<String>? deviceName,
    Value<DeviceRole>? role,
    Value<DevicePairingStatus>? pairingStatus,
    Value<String?>? lastKnownIp,
    Value<int?>? lastKnownPort,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastSeenAt,
    Value<int>? rowid,
  }) {
    return DevicesCompanion(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      role: role ?? this.role,
      pairingStatus: pairingStatus ?? this.pairingStatus,
      lastKnownIp: lastKnownIp ?? this.lastKnownIp,
      lastKnownPort: lastKnownPort ?? this.lastKnownPort,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $DevicesTable.$converterrole.toSql(role.value),
      );
    }
    if (pairingStatus.present) {
      map['pairing_status'] = Variable<String>(
        $DevicesTable.$converterpairingStatus.toSql(pairingStatus.value),
      );
    }
    if (lastKnownIp.present) {
      map['last_known_ip'] = Variable<String>(lastKnownIp.value);
    }
    if (lastKnownPort.present) {
      map['last_known_port'] = Variable<int>(lastKnownPort.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('deviceName: $deviceName, ')
          ..write('role: $role, ')
          ..write('pairingStatus: $pairingStatus, ')
          ..write('lastKnownIp: $lastKnownIp, ')
          ..write('lastKnownPort: $lastKnownPort, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmsMessagesTable extends SmsMessages
    with TableInfo<$SmsMessagesTable, SmsMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceDeviceIdMeta = const VerificationMeta(
    'sourceDeviceId',
  );
  @override
  late final GeneratedColumn<String> sourceDeviceId = GeneratedColumn<String>(
    'source_device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES devices (id)',
    ),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SmsDirection, String> direction =
      GeneratedColumn<String>(
        'direction',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('incoming'),
      ).withConverter<SmsDirection>($SmsMessagesTable.$converterdirection);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    contactName,
    content,
    receivedAt,
    sourceDeviceId,
    isRead,
    direction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('source_device_id')) {
      context.handle(
        _sourceDeviceIdMeta,
        sourceDeviceId.isAcceptableOrUnknown(
          data['source_device_id']!,
          _sourceDeviceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceDeviceIdMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      sourceDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_device_id'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      direction: $SmsMessagesTable.$converterdirection.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}direction'],
        )!,
      ),
    );
  }

  @override
  $SmsMessagesTable createAlias(String alias) {
    return $SmsMessagesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SmsDirection, String, String> $converterdirection =
      const EnumNameConverter<SmsDirection>(SmsDirection.values);
}

class SmsMessage extends DataClass implements Insertable<SmsMessage> {
  final String id;
  final String phoneNumber;
  final String? contactName;
  final String content;
  final DateTime receivedAt;
  final String sourceDeviceId;
  final bool isRead;
  final SmsDirection direction;
  const SmsMessage({
    required this.id,
    required this.phoneNumber,
    this.contactName,
    required this.content,
    required this.receivedAt,
    required this.sourceDeviceId,
    required this.isRead,
    required this.direction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    map['content'] = Variable<String>(content);
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['source_device_id'] = Variable<String>(sourceDeviceId);
    map['is_read'] = Variable<bool>(isRead);
    {
      map['direction'] = Variable<String>(
        $SmsMessagesTable.$converterdirection.toSql(direction),
      );
    }
    return map;
  }

  SmsMessagesCompanion toCompanion(bool nullToAbsent) {
    return SmsMessagesCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      content: Value(content),
      receivedAt: Value(receivedAt),
      sourceDeviceId: Value(sourceDeviceId),
      isRead: Value(isRead),
      direction: Value(direction),
    );
  }

  factory SmsMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsMessage(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      content: serializer.fromJson<String>(json['content']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      sourceDeviceId: serializer.fromJson<String>(json['sourceDeviceId']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      direction: $SmsMessagesTable.$converterdirection.fromJson(
        serializer.fromJson<String>(json['direction']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'contactName': serializer.toJson<String?>(contactName),
      'content': serializer.toJson<String>(content),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'sourceDeviceId': serializer.toJson<String>(sourceDeviceId),
      'isRead': serializer.toJson<bool>(isRead),
      'direction': serializer.toJson<String>(
        $SmsMessagesTable.$converterdirection.toJson(direction),
      ),
    };
  }

  SmsMessage copyWith({
    String? id,
    String? phoneNumber,
    Value<String?> contactName = const Value.absent(),
    String? content,
    DateTime? receivedAt,
    String? sourceDeviceId,
    bool? isRead,
    SmsDirection? direction,
  }) => SmsMessage(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    contactName: contactName.present ? contactName.value : this.contactName,
    content: content ?? this.content,
    receivedAt: receivedAt ?? this.receivedAt,
    sourceDeviceId: sourceDeviceId ?? this.sourceDeviceId,
    isRead: isRead ?? this.isRead,
    direction: direction ?? this.direction,
  );
  SmsMessage copyWithCompanion(SmsMessagesCompanion data) {
    return SmsMessage(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      content: data.content.present ? data.content.value : this.content,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      sourceDeviceId: data.sourceDeviceId.present
          ? data.sourceDeviceId.value
          : this.sourceDeviceId,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      direction: data.direction.present ? data.direction.value : this.direction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessage(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('content: $content, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('sourceDeviceId: $sourceDeviceId, ')
          ..write('isRead: $isRead, ')
          ..write('direction: $direction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phoneNumber,
    contactName,
    content,
    receivedAt,
    sourceDeviceId,
    isRead,
    direction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsMessage &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.contactName == this.contactName &&
          other.content == this.content &&
          other.receivedAt == this.receivedAt &&
          other.sourceDeviceId == this.sourceDeviceId &&
          other.isRead == this.isRead &&
          other.direction == this.direction);
}

class SmsMessagesCompanion extends UpdateCompanion<SmsMessage> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String?> contactName;
  final Value<String> content;
  final Value<DateTime> receivedAt;
  final Value<String> sourceDeviceId;
  final Value<bool> isRead;
  final Value<SmsDirection> direction;
  final Value<int> rowid;
  const SmsMessagesCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.contactName = const Value.absent(),
    this.content = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.sourceDeviceId = const Value.absent(),
    this.isRead = const Value.absent(),
    this.direction = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsMessagesCompanion.insert({
    required String id,
    required String phoneNumber,
    this.contactName = const Value.absent(),
    required String content,
    required DateTime receivedAt,
    required String sourceDeviceId,
    this.isRead = const Value.absent(),
    this.direction = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       content = Value(content),
       receivedAt = Value(receivedAt),
       sourceDeviceId = Value(sourceDeviceId);
  static Insertable<SmsMessage> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? contactName,
    Expression<String>? content,
    Expression<DateTime>? receivedAt,
    Expression<String>? sourceDeviceId,
    Expression<bool>? isRead,
    Expression<String>? direction,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (contactName != null) 'contact_name': contactName,
      if (content != null) 'content': content,
      if (receivedAt != null) 'received_at': receivedAt,
      if (sourceDeviceId != null) 'source_device_id': sourceDeviceId,
      if (isRead != null) 'is_read': isRead,
      if (direction != null) 'direction': direction,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String?>? contactName,
    Value<String>? content,
    Value<DateTime>? receivedAt,
    Value<String>? sourceDeviceId,
    Value<bool>? isRead,
    Value<SmsDirection>? direction,
    Value<int>? rowid,
  }) {
    return SmsMessagesCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactName: contactName ?? this.contactName,
      content: content ?? this.content,
      receivedAt: receivedAt ?? this.receivedAt,
      sourceDeviceId: sourceDeviceId ?? this.sourceDeviceId,
      isRead: isRead ?? this.isRead,
      direction: direction ?? this.direction,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (sourceDeviceId.present) {
      map['source_device_id'] = Variable<String>(sourceDeviceId.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(
        $SmsMessagesTable.$converterdirection.toSql(direction.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessagesCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('content: $content, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('sourceDeviceId: $sourceDeviceId, ')
          ..write('isRead: $isRead, ')
          ..write('direction: $direction, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CallLogsTable extends CallLogs with TableInfo<$CallLogsTable, CallLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CallLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CallType, String> callType =
      GeneratedColumn<String>(
        'call_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CallType>($CallLogsTable.$convertercallType);
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceDeviceIdMeta = const VerificationMeta(
    'sourceDeviceId',
  );
  @override
  late final GeneratedColumn<String> sourceDeviceId = GeneratedColumn<String>(
    'source_device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES devices (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    contactName,
    callType,
    startedAt,
    endedAt,
    sourceDeviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'call_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CallLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('source_device_id')) {
      context.handle(
        _sourceDeviceIdMeta,
        sourceDeviceId.isAcceptableOrUnknown(
          data['source_device_id']!,
          _sourceDeviceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceDeviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CallLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CallLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      callType: $CallLogsTable.$convertercallType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}call_type'],
        )!,
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      sourceDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_device_id'],
      )!,
    );
  }

  @override
  $CallLogsTable createAlias(String alias) {
    return $CallLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CallType, String, String> $convertercallType =
      const EnumNameConverter<CallType>(CallType.values);
}

class CallLog extends DataClass implements Insertable<CallLog> {
  final String id;
  final String phoneNumber;
  final String? contactName;
  final CallType callType;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final String sourceDeviceId;
  const CallLog({
    required this.id,
    required this.phoneNumber,
    this.contactName,
    required this.callType,
    this.startedAt,
    this.endedAt,
    required this.sourceDeviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    {
      map['call_type'] = Variable<String>(
        $CallLogsTable.$convertercallType.toSql(callType),
      );
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['source_device_id'] = Variable<String>(sourceDeviceId);
    return map;
  }

  CallLogsCompanion toCompanion(bool nullToAbsent) {
    return CallLogsCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      callType: Value(callType),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      sourceDeviceId: Value(sourceDeviceId),
    );
  }

  factory CallLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CallLog(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      callType: $CallLogsTable.$convertercallType.fromJson(
        serializer.fromJson<String>(json['callType']),
      ),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      sourceDeviceId: serializer.fromJson<String>(json['sourceDeviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'contactName': serializer.toJson<String?>(contactName),
      'callType': serializer.toJson<String>(
        $CallLogsTable.$convertercallType.toJson(callType),
      ),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'sourceDeviceId': serializer.toJson<String>(sourceDeviceId),
    };
  }

  CallLog copyWith({
    String? id,
    String? phoneNumber,
    Value<String?> contactName = const Value.absent(),
    CallType? callType,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> endedAt = const Value.absent(),
    String? sourceDeviceId,
  }) => CallLog(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    contactName: contactName.present ? contactName.value : this.contactName,
    callType: callType ?? this.callType,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    sourceDeviceId: sourceDeviceId ?? this.sourceDeviceId,
  );
  CallLog copyWithCompanion(CallLogsCompanion data) {
    return CallLog(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      callType: data.callType.present ? data.callType.value : this.callType,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      sourceDeviceId: data.sourceDeviceId.present
          ? data.sourceDeviceId.value
          : this.sourceDeviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CallLog(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('callType: $callType, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('sourceDeviceId: $sourceDeviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phoneNumber,
    contactName,
    callType,
    startedAt,
    endedAt,
    sourceDeviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallLog &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.contactName == this.contactName &&
          other.callType == this.callType &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.sourceDeviceId == this.sourceDeviceId);
}

class CallLogsCompanion extends UpdateCompanion<CallLog> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String?> contactName;
  final Value<CallType> callType;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String> sourceDeviceId;
  final Value<int> rowid;
  const CallLogsCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.contactName = const Value.absent(),
    this.callType = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.sourceDeviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CallLogsCompanion.insert({
    required String id,
    required String phoneNumber,
    this.contactName = const Value.absent(),
    required CallType callType,
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    required String sourceDeviceId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       callType = Value(callType),
       sourceDeviceId = Value(sourceDeviceId);
  static Insertable<CallLog> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? contactName,
    Expression<String>? callType,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? sourceDeviceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (contactName != null) 'contact_name': contactName,
      if (callType != null) 'call_type': callType,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (sourceDeviceId != null) 'source_device_id': sourceDeviceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CallLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String?>? contactName,
    Value<CallType>? callType,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String>? sourceDeviceId,
    Value<int>? rowid,
  }) {
    return CallLogsCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactName: contactName ?? this.contactName,
      callType: callType ?? this.callType,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      sourceDeviceId: sourceDeviceId ?? this.sourceDeviceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (callType.present) {
      map['call_type'] = Variable<String>(
        $CallLogsTable.$convertercallType.toSql(callType.value),
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (sourceDeviceId.present) {
      map['source_device_id'] = Variable<String>(sourceDeviceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CallLogsCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('callType: $callType, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('sourceDeviceId: $sourceDeviceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncEventsTable extends SyncEvents
    with TableInfo<$SyncEventsTable, SyncEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncEntityType, String>
  entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SyncEntityType>($SyncEventsTable.$converterentityType);
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncEventType, String> eventType =
      GeneratedColumn<String>(
        'event_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncEventType>($SyncEventsTable.$convertereventType);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    eventType,
    createdAt,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: $SyncEventsTable.$converterentityType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}entity_type'],
        )!,
      ),
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      eventType: $SyncEventsTable.$convertereventType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}event_type'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $SyncEventsTable createAlias(String alias) {
    return $SyncEventsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncEntityType, String, String>
  $converterentityType = const EnumNameConverter<SyncEntityType>(
    SyncEntityType.values,
  );
  static JsonTypeConverter2<SyncEventType, String, String> $convertereventType =
      const EnumNameConverter<SyncEventType>(SyncEventType.values);
}

class SyncEvent extends DataClass implements Insertable<SyncEvent> {
  final String id;
  final SyncEntityType entityType;
  final String entityId;
  final SyncEventType eventType;
  final DateTime createdAt;
  final bool synced;
  const SyncEvent({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.eventType,
    required this.createdAt,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['entity_type'] = Variable<String>(
        $SyncEventsTable.$converterentityType.toSql(entityType),
      );
    }
    map['entity_id'] = Variable<String>(entityId);
    {
      map['event_type'] = Variable<String>(
        $SyncEventsTable.$convertereventType.toSql(eventType),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  SyncEventsCompanion toCompanion(bool nullToAbsent) {
    return SyncEventsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      eventType: Value(eventType),
      createdAt: Value(createdAt),
      synced: Value(synced),
    );
  }

  factory SyncEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncEvent(
      id: serializer.fromJson<String>(json['id']),
      entityType: $SyncEventsTable.$converterentityType.fromJson(
        serializer.fromJson<String>(json['entityType']),
      ),
      entityId: serializer.fromJson<String>(json['entityId']),
      eventType: $SyncEventsTable.$convertereventType.fromJson(
        serializer.fromJson<String>(json['eventType']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(
        $SyncEventsTable.$converterentityType.toJson(entityType),
      ),
      'entityId': serializer.toJson<String>(entityId),
      'eventType': serializer.toJson<String>(
        $SyncEventsTable.$convertereventType.toJson(eventType),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  SyncEvent copyWith({
    String? id,
    SyncEntityType? entityType,
    String? entityId,
    SyncEventType? eventType,
    DateTime? createdAt,
    bool? synced,
  }) => SyncEvent(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    eventType: eventType ?? this.eventType,
    createdAt: createdAt ?? this.createdAt,
    synced: synced ?? this.synced,
  );
  SyncEvent copyWithCompanion(SyncEventsCompanion data) {
    return SyncEvent(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncEvent(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('eventType: $eventType, ')
          ..write('createdAt: $createdAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entityType, entityId, eventType, createdAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncEvent &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.eventType == this.eventType &&
          other.createdAt == this.createdAt &&
          other.synced == this.synced);
}

class SyncEventsCompanion extends UpdateCompanion<SyncEvent> {
  final Value<String> id;
  final Value<SyncEntityType> entityType;
  final Value<String> entityId;
  final Value<SyncEventType> eventType;
  final Value<DateTime> createdAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const SyncEventsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncEventsCompanion.insert({
    required String id,
    required SyncEntityType entityType,
    required String entityId,
    required SyncEventType eventType,
    this.createdAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       eventType = Value(eventType);
  static Insertable<SyncEvent> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? eventType,
    Expression<DateTime>? createdAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (eventType != null) 'event_type': eventType,
      if (createdAt != null) 'created_at': createdAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncEventsCompanion copyWith({
    Value<String>? id,
    Value<SyncEntityType>? entityType,
    Value<String>? entityId,
    Value<SyncEventType>? eventType,
    Value<DateTime>? createdAt,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return SyncEventsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      eventType: eventType ?? this.eventType,
      createdAt: createdAt ?? this.createdAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(
        $SyncEventsTable.$converterentityType.toSql(entityType.value),
      );
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(
        $SyncEventsTable.$convertereventType.toSql(eventType.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncEventsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('eventType: $eventType, ')
          ..write('createdAt: $createdAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $SmsMessagesTable smsMessages = $SmsMessagesTable(this);
  late final $CallLogsTable callLogs = $CallLogsTable(this);
  late final $SyncEventsTable syncEvents = $SyncEventsTable(this);
  late final DevicesDao devicesDao = DevicesDao(this as AppDatabase);
  late final SmsDao smsDao = SmsDao(this as AppDatabase);
  late final CallsDao callsDao = CallsDao(this as AppDatabase);
  late final SyncEventsDao syncEventsDao = SyncEventsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    devices,
    smsMessages,
    callLogs,
    syncEvents,
  ];
}

typedef $$DevicesTableCreateCompanionBuilder =
    DevicesCompanion Function({
      required String id,
      required String deviceName,
      required DeviceRole role,
      Value<DevicePairingStatus> pairingStatus,
      Value<String?> lastKnownIp,
      Value<int?> lastKnownPort,
      Value<DateTime> createdAt,
      Value<DateTime?> lastSeenAt,
      Value<int> rowid,
    });
typedef $$DevicesTableUpdateCompanionBuilder =
    DevicesCompanion Function({
      Value<String> id,
      Value<String> deviceName,
      Value<DeviceRole> role,
      Value<DevicePairingStatus> pairingStatus,
      Value<String?> lastKnownIp,
      Value<int?> lastKnownPort,
      Value<DateTime> createdAt,
      Value<DateTime?> lastSeenAt,
      Value<int> rowid,
    });

final class $$DevicesTableReferences
    extends BaseReferences<_$AppDatabase, $DevicesTable, Device> {
  $$DevicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SmsMessagesTable, List<SmsMessage>>
  _smsMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.smsMessages,
    aliasName: $_aliasNameGenerator(
      db.devices.id,
      db.smsMessages.sourceDeviceId,
    ),
  );

  $$SmsMessagesTableProcessedTableManager get smsMessagesRefs {
    final manager = $$SmsMessagesTableTableManager(
      $_db,
      $_db.smsMessages,
    ).filter((f) => f.sourceDeviceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_smsMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CallLogsTable, List<CallLog>> _callLogsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.callLogs,
    aliasName: $_aliasNameGenerator(db.devices.id, db.callLogs.sourceDeviceId),
  );

  $$CallLogsTableProcessedTableManager get callLogsRefs {
    final manager = $$CallLogsTableTableManager(
      $_db,
      $_db.callLogs,
    ).filter((f) => f.sourceDeviceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_callLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DevicesTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DeviceRole, DeviceRole, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<
    DevicePairingStatus,
    DevicePairingStatus,
    String
  >
  get pairingStatus => $composableBuilder(
    column: $table.pairingStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get lastKnownIp => $composableBuilder(
    column: $table.lastKnownIp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastKnownPort => $composableBuilder(
    column: $table.lastKnownPort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> smsMessagesRefs(
    Expression<bool> Function($$SmsMessagesTableFilterComposer f) f,
  ) {
    final $$SmsMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessages,
      getReferencedColumn: (t) => t.sourceDeviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmsMessagesTableFilterComposer(
            $db: $db,
            $table: $db.smsMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> callLogsRefs(
    Expression<bool> Function($$CallLogsTableFilterComposer f) f,
  ) {
    final $$CallLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.callLogs,
      getReferencedColumn: (t) => t.sourceDeviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallLogsTableFilterComposer(
            $db: $db,
            $table: $db.callLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pairingStatus => $composableBuilder(
    column: $table.pairingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastKnownIp => $composableBuilder(
    column: $table.lastKnownIp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastKnownPort => $composableBuilder(
    column: $table.lastKnownPort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DeviceRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DevicePairingStatus, String>
  get pairingStatus => $composableBuilder(
    column: $table.pairingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastKnownIp => $composableBuilder(
    column: $table.lastKnownIp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastKnownPort => $composableBuilder(
    column: $table.lastKnownPort,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );

  Expression<T> smsMessagesRefs<T extends Object>(
    Expression<T> Function($$SmsMessagesTableAnnotationComposer a) f,
  ) {
    final $$SmsMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smsMessages,
      getReferencedColumn: (t) => t.sourceDeviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmsMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.smsMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> callLogsRefs<T extends Object>(
    Expression<T> Function($$CallLogsTableAnnotationComposer a) f,
  ) {
    final $$CallLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.callLogs,
      getReferencedColumn: (t) => t.sourceDeviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.callLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DevicesTable,
          Device,
          $$DevicesTableFilterComposer,
          $$DevicesTableOrderingComposer,
          $$DevicesTableAnnotationComposer,
          $$DevicesTableCreateCompanionBuilder,
          $$DevicesTableUpdateCompanionBuilder,
          (Device, $$DevicesTableReferences),
          Device,
          PrefetchHooks Function({bool smsMessagesRefs, bool callLogsRefs})
        > {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> deviceName = const Value.absent(),
                Value<DeviceRole> role = const Value.absent(),
                Value<DevicePairingStatus> pairingStatus = const Value.absent(),
                Value<String?> lastKnownIp = const Value.absent(),
                Value<int?> lastKnownPort = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion(
                id: id,
                deviceName: deviceName,
                role: role,
                pairingStatus: pairingStatus,
                lastKnownIp: lastKnownIp,
                lastKnownPort: lastKnownPort,
                createdAt: createdAt,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String deviceName,
                required DeviceRole role,
                Value<DevicePairingStatus> pairingStatus = const Value.absent(),
                Value<String?> lastKnownIp = const Value.absent(),
                Value<int?> lastKnownPort = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion.insert(
                id: id,
                deviceName: deviceName,
                role: role,
                pairingStatus: pairingStatus,
                lastKnownIp: lastKnownIp,
                lastKnownPort: lastKnownPort,
                createdAt: createdAt,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DevicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({smsMessagesRefs = false, callLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (smsMessagesRefs) db.smsMessages,
                    if (callLogsRefs) db.callLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (smsMessagesRefs)
                        await $_getPrefetchedData<
                          Device,
                          $DevicesTable,
                          SmsMessage
                        >(
                          currentTable: table,
                          referencedTable: $$DevicesTableReferences
                              ._smsMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DevicesTableReferences(
                                db,
                                table,
                                p0,
                              ).smsMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceDeviceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (callLogsRefs)
                        await $_getPrefetchedData<
                          Device,
                          $DevicesTable,
                          CallLog
                        >(
                          currentTable: table,
                          referencedTable: $$DevicesTableReferences
                              ._callLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DevicesTableReferences(
                                db,
                                table,
                                p0,
                              ).callLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceDeviceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DevicesTable,
      Device,
      $$DevicesTableFilterComposer,
      $$DevicesTableOrderingComposer,
      $$DevicesTableAnnotationComposer,
      $$DevicesTableCreateCompanionBuilder,
      $$DevicesTableUpdateCompanionBuilder,
      (Device, $$DevicesTableReferences),
      Device,
      PrefetchHooks Function({bool smsMessagesRefs, bool callLogsRefs})
    >;
typedef $$SmsMessagesTableCreateCompanionBuilder =
    SmsMessagesCompanion Function({
      required String id,
      required String phoneNumber,
      Value<String?> contactName,
      required String content,
      required DateTime receivedAt,
      required String sourceDeviceId,
      Value<bool> isRead,
      Value<SmsDirection> direction,
      Value<int> rowid,
    });
typedef $$SmsMessagesTableUpdateCompanionBuilder =
    SmsMessagesCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String?> contactName,
      Value<String> content,
      Value<DateTime> receivedAt,
      Value<String> sourceDeviceId,
      Value<bool> isRead,
      Value<SmsDirection> direction,
      Value<int> rowid,
    });

final class $$SmsMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $SmsMessagesTable, SmsMessage> {
  $$SmsMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DevicesTable _sourceDeviceIdTable(_$AppDatabase db) =>
      db.devices.createAlias(
        $_aliasNameGenerator(db.smsMessages.sourceDeviceId, db.devices.id),
      );

  $$DevicesTableProcessedTableManager get sourceDeviceId {
    final $_column = $_itemColumn<String>('source_device_id')!;

    final manager = $$DevicesTableTableManager(
      $_db,
      $_db.devices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceDeviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmsMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $SmsMessagesTable> {
  $$SmsMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SmsDirection, SmsDirection, String>
  get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$DevicesTableFilterComposer get sourceDeviceId {
    final $$DevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableFilterComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmsMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsMessagesTable> {
  $$SmsMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  $$DevicesTableOrderingComposer get sourceDeviceId {
    final $$DevicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableOrderingComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmsMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsMessagesTable> {
  $$SmsMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SmsDirection, String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  $$DevicesTableAnnotationComposer get sourceDeviceId {
    final $$DevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmsMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SmsMessagesTable,
          SmsMessage,
          $$SmsMessagesTableFilterComposer,
          $$SmsMessagesTableOrderingComposer,
          $$SmsMessagesTableAnnotationComposer,
          $$SmsMessagesTableCreateCompanionBuilder,
          $$SmsMessagesTableUpdateCompanionBuilder,
          (SmsMessage, $$SmsMessagesTableReferences),
          SmsMessage,
          PrefetchHooks Function({bool sourceDeviceId})
        > {
  $$SmsMessagesTableTableManager(_$AppDatabase db, $SmsMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmsMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmsMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmsMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<String> sourceDeviceId = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<SmsDirection> direction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsMessagesCompanion(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                content: content,
                receivedAt: receivedAt,
                sourceDeviceId: sourceDeviceId,
                isRead: isRead,
                direction: direction,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                Value<String?> contactName = const Value.absent(),
                required String content,
                required DateTime receivedAt,
                required String sourceDeviceId,
                Value<bool> isRead = const Value.absent(),
                Value<SmsDirection> direction = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsMessagesCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                content: content,
                receivedAt: receivedAt,
                sourceDeviceId: sourceDeviceId,
                isRead: isRead,
                direction: direction,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SmsMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sourceDeviceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceDeviceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sourceDeviceId,
                                referencedTable: $$SmsMessagesTableReferences
                                    ._sourceDeviceIdTable(db),
                                referencedColumn: $$SmsMessagesTableReferences
                                    ._sourceDeviceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SmsMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SmsMessagesTable,
      SmsMessage,
      $$SmsMessagesTableFilterComposer,
      $$SmsMessagesTableOrderingComposer,
      $$SmsMessagesTableAnnotationComposer,
      $$SmsMessagesTableCreateCompanionBuilder,
      $$SmsMessagesTableUpdateCompanionBuilder,
      (SmsMessage, $$SmsMessagesTableReferences),
      SmsMessage,
      PrefetchHooks Function({bool sourceDeviceId})
    >;
typedef $$CallLogsTableCreateCompanionBuilder =
    CallLogsCompanion Function({
      required String id,
      required String phoneNumber,
      Value<String?> contactName,
      required CallType callType,
      Value<DateTime?> startedAt,
      Value<DateTime?> endedAt,
      required String sourceDeviceId,
      Value<int> rowid,
    });
typedef $$CallLogsTableUpdateCompanionBuilder =
    CallLogsCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String?> contactName,
      Value<CallType> callType,
      Value<DateTime?> startedAt,
      Value<DateTime?> endedAt,
      Value<String> sourceDeviceId,
      Value<int> rowid,
    });

final class $$CallLogsTableReferences
    extends BaseReferences<_$AppDatabase, $CallLogsTable, CallLog> {
  $$CallLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DevicesTable _sourceDeviceIdTable(_$AppDatabase db) =>
      db.devices.createAlias(
        $_aliasNameGenerator(db.callLogs.sourceDeviceId, db.devices.id),
      );

  $$DevicesTableProcessedTableManager get sourceDeviceId {
    final $_column = $_itemColumn<String>('source_device_id')!;

    final manager = $$DevicesTableTableManager(
      $_db,
      $_db.devices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceDeviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CallLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CallLogsTable> {
  $$CallLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CallType, CallType, String> get callType =>
      $composableBuilder(
        column: $table.callType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DevicesTableFilterComposer get sourceDeviceId {
    final $$DevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableFilterComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CallLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CallLogsTable> {
  $$CallLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get callType => $composableBuilder(
    column: $table.callType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DevicesTableOrderingComposer get sourceDeviceId {
    final $$DevicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableOrderingComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CallLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CallLogsTable> {
  $$CallLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CallType, String> get callType =>
      $composableBuilder(column: $table.callType, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$DevicesTableAnnotationComposer get sourceDeviceId {
    final $$DevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CallLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CallLogsTable,
          CallLog,
          $$CallLogsTableFilterComposer,
          $$CallLogsTableOrderingComposer,
          $$CallLogsTableAnnotationComposer,
          $$CallLogsTableCreateCompanionBuilder,
          $$CallLogsTableUpdateCompanionBuilder,
          (CallLog, $$CallLogsTableReferences),
          CallLog,
          PrefetchHooks Function({bool sourceDeviceId})
        > {
  $$CallLogsTableTableManager(_$AppDatabase db, $CallLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CallLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CallLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CallLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<CallType> callType = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String> sourceDeviceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CallLogsCompanion(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                callType: callType,
                startedAt: startedAt,
                endedAt: endedAt,
                sourceDeviceId: sourceDeviceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                Value<String?> contactName = const Value.absent(),
                required CallType callType,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                required String sourceDeviceId,
                Value<int> rowid = const Value.absent(),
              }) => CallLogsCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                callType: callType,
                startedAt: startedAt,
                endedAt: endedAt,
                sourceDeviceId: sourceDeviceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CallLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sourceDeviceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceDeviceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sourceDeviceId,
                                referencedTable: $$CallLogsTableReferences
                                    ._sourceDeviceIdTable(db),
                                referencedColumn: $$CallLogsTableReferences
                                    ._sourceDeviceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CallLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CallLogsTable,
      CallLog,
      $$CallLogsTableFilterComposer,
      $$CallLogsTableOrderingComposer,
      $$CallLogsTableAnnotationComposer,
      $$CallLogsTableCreateCompanionBuilder,
      $$CallLogsTableUpdateCompanionBuilder,
      (CallLog, $$CallLogsTableReferences),
      CallLog,
      PrefetchHooks Function({bool sourceDeviceId})
    >;
typedef $$SyncEventsTableCreateCompanionBuilder =
    SyncEventsCompanion Function({
      required String id,
      required SyncEntityType entityType,
      required String entityId,
      required SyncEventType eventType,
      Value<DateTime> createdAt,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$SyncEventsTableUpdateCompanionBuilder =
    SyncEventsCompanion Function({
      Value<String> id,
      Value<SyncEntityType> entityType,
      Value<String> entityId,
      Value<SyncEventType> eventType,
      Value<DateTime> createdAt,
      Value<bool> synced,
      Value<int> rowid,
    });

class $$SyncEventsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncEventsTable> {
  $$SyncEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncEntityType, SyncEntityType, String>
  get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncEventType, SyncEventType, String>
  get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncEventsTable> {
  $$SyncEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncEventsTable> {
  $$SyncEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncEntityType, String> get entityType =>
      $composableBuilder(
        column: $table.entityType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncEventType, String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$SyncEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncEventsTable,
          SyncEvent,
          $$SyncEventsTableFilterComposer,
          $$SyncEventsTableOrderingComposer,
          $$SyncEventsTableAnnotationComposer,
          $$SyncEventsTableCreateCompanionBuilder,
          $$SyncEventsTableUpdateCompanionBuilder,
          (
            SyncEvent,
            BaseReferences<_$AppDatabase, $SyncEventsTable, SyncEvent>,
          ),
          SyncEvent,
          PrefetchHooks Function()
        > {
  $$SyncEventsTableTableManager(_$AppDatabase db, $SyncEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<SyncEntityType> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<SyncEventType> eventType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncEventsCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                eventType: eventType,
                createdAt: createdAt,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required SyncEntityType entityType,
                required String entityId,
                required SyncEventType eventType,
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncEventsCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                eventType: eventType,
                createdAt: createdAt,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncEventsTable,
      SyncEvent,
      $$SyncEventsTableFilterComposer,
      $$SyncEventsTableOrderingComposer,
      $$SyncEventsTableAnnotationComposer,
      $$SyncEventsTableCreateCompanionBuilder,
      $$SyncEventsTableUpdateCompanionBuilder,
      (SyncEvent, BaseReferences<_$AppDatabase, $SyncEventsTable, SyncEvent>),
      SyncEvent,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$SmsMessagesTableTableManager get smsMessages =>
      $$SmsMessagesTableTableManager(_db, _db.smsMessages);
  $$CallLogsTableTableManager get callLogs =>
      $$CallLogsTableTableManager(_db, _db.callLogs);
  $$SyncEventsTableTableManager get syncEvents =>
      $$SyncEventsTableTableManager(_db, _db.syncEvents);
}
