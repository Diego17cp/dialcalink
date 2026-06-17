// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_log_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CallLogEntity {
  String get id => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  CallType get callType => throw _privateConstructorUsedError;
  String get sourceDeviceId => throw _privateConstructorUsedError;
  String? get contactName => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;

  /// Create a copy of CallLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallLogEntityCopyWith<CallLogEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallLogEntityCopyWith<$Res> {
  factory $CallLogEntityCopyWith(
    CallLogEntity value,
    $Res Function(CallLogEntity) then,
  ) = _$CallLogEntityCopyWithImpl<$Res, CallLogEntity>;
  @useResult
  $Res call({
    String id,
    String phoneNumber,
    CallType callType,
    String sourceDeviceId,
    String? contactName,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class _$CallLogEntityCopyWithImpl<$Res, $Val extends CallLogEntity>
    implements $CallLogEntityCopyWith<$Res> {
  _$CallLogEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? callType = null,
    Object? sourceDeviceId = null,
    Object? contactName = freezed,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            callType: null == callType
                ? _value.callType
                : callType // ignore: cast_nullable_to_non_nullable
                      as CallType,
            sourceDeviceId: null == sourceDeviceId
                ? _value.sourceDeviceId
                : sourceDeviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            contactName: freezed == contactName
                ? _value.contactName
                : contactName // ignore: cast_nullable_to_non_nullable
                      as String?,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallLogEntityImplCopyWith<$Res>
    implements $CallLogEntityCopyWith<$Res> {
  factory _$$CallLogEntityImplCopyWith(
    _$CallLogEntityImpl value,
    $Res Function(_$CallLogEntityImpl) then,
  ) = __$$CallLogEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phoneNumber,
    CallType callType,
    String sourceDeviceId,
    String? contactName,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class __$$CallLogEntityImplCopyWithImpl<$Res>
    extends _$CallLogEntityCopyWithImpl<$Res, _$CallLogEntityImpl>
    implements _$$CallLogEntityImplCopyWith<$Res> {
  __$$CallLogEntityImplCopyWithImpl(
    _$CallLogEntityImpl _value,
    $Res Function(_$CallLogEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? callType = null,
    Object? sourceDeviceId = null,
    Object? contactName = freezed,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
  }) {
    return _then(
      _$CallLogEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        callType: null == callType
            ? _value.callType
            : callType // ignore: cast_nullable_to_non_nullable
                  as CallType,
        sourceDeviceId: null == sourceDeviceId
            ? _value.sourceDeviceId
            : sourceDeviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        contactName: freezed == contactName
            ? _value.contactName
            : contactName // ignore: cast_nullable_to_non_nullable
                  as String?,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$CallLogEntityImpl extends _CallLogEntity {
  const _$CallLogEntityImpl({
    required this.id,
    required this.phoneNumber,
    required this.callType,
    required this.sourceDeviceId,
    this.contactName,
    this.startedAt,
    this.endedAt,
  }) : super._();

  @override
  final String id;
  @override
  final String phoneNumber;
  @override
  final CallType callType;
  @override
  final String sourceDeviceId;
  @override
  final String? contactName;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;

  @override
  String toString() {
    return 'CallLogEntity(id: $id, phoneNumber: $phoneNumber, callType: $callType, sourceDeviceId: $sourceDeviceId, contactName: $contactName, startedAt: $startedAt, endedAt: $endedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallLogEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.sourceDeviceId, sourceDeviceId) ||
                other.sourceDeviceId == sourceDeviceId) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phoneNumber,
    callType,
    sourceDeviceId,
    contactName,
    startedAt,
    endedAt,
  );

  /// Create a copy of CallLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallLogEntityImplCopyWith<_$CallLogEntityImpl> get copyWith =>
      __$$CallLogEntityImplCopyWithImpl<_$CallLogEntityImpl>(this, _$identity);
}

abstract class _CallLogEntity extends CallLogEntity {
  const factory _CallLogEntity({
    required final String id,
    required final String phoneNumber,
    required final CallType callType,
    required final String sourceDeviceId,
    final String? contactName,
    final DateTime? startedAt,
    final DateTime? endedAt,
  }) = _$CallLogEntityImpl;
  const _CallLogEntity._() : super._();

  @override
  String get id;
  @override
  String get phoneNumber;
  @override
  CallType get callType;
  @override
  String get sourceDeviceId;
  @override
  String? get contactName;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get endedAt;

  /// Create a copy of CallLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallLogEntityImplCopyWith<_$CallLogEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
