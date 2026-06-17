// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DeviceEntity {
  String get id => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  DeviceRole get role => throw _privateConstructorUsedError;
  DevicePairingStatus get pairingStatus => throw _privateConstructorUsedError;
  String? get lastKnownIp => throw _privateConstructorUsedError;
  int? get lastKnownPort => throw _privateConstructorUsedError;
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceEntityCopyWith<DeviceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceEntityCopyWith<$Res> {
  factory $DeviceEntityCopyWith(
    DeviceEntity value,
    $Res Function(DeviceEntity) then,
  ) = _$DeviceEntityCopyWithImpl<$Res, DeviceEntity>;
  @useResult
  $Res call({
    String id,
    String deviceName,
    DeviceRole role,
    DevicePairingStatus pairingStatus,
    String? lastKnownIp,
    int? lastKnownPort,
    DateTime? lastSeenAt,
  });
}

/// @nodoc
class _$DeviceEntityCopyWithImpl<$Res, $Val extends DeviceEntity>
    implements $DeviceEntityCopyWith<$Res> {
  _$DeviceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceName = null,
    Object? role = null,
    Object? pairingStatus = null,
    Object? lastKnownIp = freezed,
    Object? lastKnownPort = freezed,
    Object? lastSeenAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceName: null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as DeviceRole,
            pairingStatus: null == pairingStatus
                ? _value.pairingStatus
                : pairingStatus // ignore: cast_nullable_to_non_nullable
                      as DevicePairingStatus,
            lastKnownIp: freezed == lastKnownIp
                ? _value.lastKnownIp
                : lastKnownIp // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastKnownPort: freezed == lastKnownPort
                ? _value.lastKnownPort
                : lastKnownPort // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastSeenAt: freezed == lastSeenAt
                ? _value.lastSeenAt
                : lastSeenAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceEntityImplCopyWith<$Res>
    implements $DeviceEntityCopyWith<$Res> {
  factory _$$DeviceEntityImplCopyWith(
    _$DeviceEntityImpl value,
    $Res Function(_$DeviceEntityImpl) then,
  ) = __$$DeviceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String deviceName,
    DeviceRole role,
    DevicePairingStatus pairingStatus,
    String? lastKnownIp,
    int? lastKnownPort,
    DateTime? lastSeenAt,
  });
}

/// @nodoc
class __$$DeviceEntityImplCopyWithImpl<$Res>
    extends _$DeviceEntityCopyWithImpl<$Res, _$DeviceEntityImpl>
    implements _$$DeviceEntityImplCopyWith<$Res> {
  __$$DeviceEntityImplCopyWithImpl(
    _$DeviceEntityImpl _value,
    $Res Function(_$DeviceEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceName = null,
    Object? role = null,
    Object? pairingStatus = null,
    Object? lastKnownIp = freezed,
    Object? lastKnownPort = freezed,
    Object? lastSeenAt = freezed,
  }) {
    return _then(
      _$DeviceEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as DeviceRole,
        pairingStatus: null == pairingStatus
            ? _value.pairingStatus
            : pairingStatus // ignore: cast_nullable_to_non_nullable
                  as DevicePairingStatus,
        lastKnownIp: freezed == lastKnownIp
            ? _value.lastKnownIp
            : lastKnownIp // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastKnownPort: freezed == lastKnownPort
            ? _value.lastKnownPort
            : lastKnownPort // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastSeenAt: freezed == lastSeenAt
            ? _value.lastSeenAt
            : lastSeenAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$DeviceEntityImpl extends _DeviceEntity {
  const _$DeviceEntityImpl({
    required this.id,
    required this.deviceName,
    required this.role,
    required this.pairingStatus,
    this.lastKnownIp,
    this.lastKnownPort,
    this.lastSeenAt,
  }) : super._();

  @override
  final String id;
  @override
  final String deviceName;
  @override
  final DeviceRole role;
  @override
  final DevicePairingStatus pairingStatus;
  @override
  final String? lastKnownIp;
  @override
  final int? lastKnownPort;
  @override
  final DateTime? lastSeenAt;

  @override
  String toString() {
    return 'DeviceEntity(id: $id, deviceName: $deviceName, role: $role, pairingStatus: $pairingStatus, lastKnownIp: $lastKnownIp, lastKnownPort: $lastKnownPort, lastSeenAt: $lastSeenAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.pairingStatus, pairingStatus) ||
                other.pairingStatus == pairingStatus) &&
            (identical(other.lastKnownIp, lastKnownIp) ||
                other.lastKnownIp == lastKnownIp) &&
            (identical(other.lastKnownPort, lastKnownPort) ||
                other.lastKnownPort == lastKnownPort) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deviceName,
    role,
    pairingStatus,
    lastKnownIp,
    lastKnownPort,
    lastSeenAt,
  );

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceEntityImplCopyWith<_$DeviceEntityImpl> get copyWith =>
      __$$DeviceEntityImplCopyWithImpl<_$DeviceEntityImpl>(this, _$identity);
}

abstract class _DeviceEntity extends DeviceEntity {
  const factory _DeviceEntity({
    required final String id,
    required final String deviceName,
    required final DeviceRole role,
    required final DevicePairingStatus pairingStatus,
    final String? lastKnownIp,
    final int? lastKnownPort,
    final DateTime? lastSeenAt,
  }) = _$DeviceEntityImpl;
  const _DeviceEntity._() : super._();

  @override
  String get id;
  @override
  String get deviceName;
  @override
  DeviceRole get role;
  @override
  DevicePairingStatus get pairingStatus;
  @override
  String? get lastKnownIp;
  @override
  int? get lastKnownPort;
  @override
  DateTime? get lastSeenAt;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceEntityImplCopyWith<_$DeviceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
