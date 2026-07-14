// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SmsMessageEntity {
  String get id => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get receivedAt => throw _privateConstructorUsedError;
  String get sourceDeviceId => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  String? get contactName => throw _privateConstructorUsedError;
  SmsDirection get direction => throw _privateConstructorUsedError;

  /// Create a copy of SmsMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsMessageEntityCopyWith<SmsMessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsMessageEntityCopyWith<$Res> {
  factory $SmsMessageEntityCopyWith(
    SmsMessageEntity value,
    $Res Function(SmsMessageEntity) then,
  ) = _$SmsMessageEntityCopyWithImpl<$Res, SmsMessageEntity>;
  @useResult
  $Res call({
    String id,
    String phoneNumber,
    String content,
    DateTime receivedAt,
    String sourceDeviceId,
    bool isRead,
    String? contactName,
    SmsDirection direction,
  });
}

/// @nodoc
class _$SmsMessageEntityCopyWithImpl<$Res, $Val extends SmsMessageEntity>
    implements $SmsMessageEntityCopyWith<$Res> {
  _$SmsMessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? content = null,
    Object? receivedAt = null,
    Object? sourceDeviceId = null,
    Object? isRead = null,
    Object? contactName = freezed,
    Object? direction = null,
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
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            receivedAt: null == receivedAt
                ? _value.receivedAt
                : receivedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            sourceDeviceId: null == sourceDeviceId
                ? _value.sourceDeviceId
                : sourceDeviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            contactName: freezed == contactName
                ? _value.contactName
                : contactName // ignore: cast_nullable_to_non_nullable
                      as String?,
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as SmsDirection,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmsMessageEntityImplCopyWith<$Res>
    implements $SmsMessageEntityCopyWith<$Res> {
  factory _$$SmsMessageEntityImplCopyWith(
    _$SmsMessageEntityImpl value,
    $Res Function(_$SmsMessageEntityImpl) then,
  ) = __$$SmsMessageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phoneNumber,
    String content,
    DateTime receivedAt,
    String sourceDeviceId,
    bool isRead,
    String? contactName,
    SmsDirection direction,
  });
}

/// @nodoc
class __$$SmsMessageEntityImplCopyWithImpl<$Res>
    extends _$SmsMessageEntityCopyWithImpl<$Res, _$SmsMessageEntityImpl>
    implements _$$SmsMessageEntityImplCopyWith<$Res> {
  __$$SmsMessageEntityImplCopyWithImpl(
    _$SmsMessageEntityImpl _value,
    $Res Function(_$SmsMessageEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmsMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? content = null,
    Object? receivedAt = null,
    Object? sourceDeviceId = null,
    Object? isRead = null,
    Object? contactName = freezed,
    Object? direction = null,
  }) {
    return _then(
      _$SmsMessageEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        receivedAt: null == receivedAt
            ? _value.receivedAt
            : receivedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        sourceDeviceId: null == sourceDeviceId
            ? _value.sourceDeviceId
            : sourceDeviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        contactName: freezed == contactName
            ? _value.contactName
            : contactName // ignore: cast_nullable_to_non_nullable
                  as String?,
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as SmsDirection,
      ),
    );
  }
}

/// @nodoc

class _$SmsMessageEntityImpl extends _SmsMessageEntity {
  const _$SmsMessageEntityImpl({
    required this.id,
    required this.phoneNumber,
    required this.content,
    required this.receivedAt,
    required this.sourceDeviceId,
    required this.isRead,
    this.contactName,
    required this.direction,
  }) : super._();

  @override
  final String id;
  @override
  final String phoneNumber;
  @override
  final String content;
  @override
  final DateTime receivedAt;
  @override
  final String sourceDeviceId;
  @override
  final bool isRead;
  @override
  final String? contactName;
  @override
  final SmsDirection direction;

  @override
  String toString() {
    return 'SmsMessageEntity(id: $id, phoneNumber: $phoneNumber, content: $content, receivedAt: $receivedAt, sourceDeviceId: $sourceDeviceId, isRead: $isRead, contactName: $contactName, direction: $direction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsMessageEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt) &&
            (identical(other.sourceDeviceId, sourceDeviceId) ||
                other.sourceDeviceId == sourceDeviceId) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phoneNumber,
    content,
    receivedAt,
    sourceDeviceId,
    isRead,
    contactName,
    direction,
  );

  /// Create a copy of SmsMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsMessageEntityImplCopyWith<_$SmsMessageEntityImpl> get copyWith =>
      __$$SmsMessageEntityImplCopyWithImpl<_$SmsMessageEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _SmsMessageEntity extends SmsMessageEntity {
  const factory _SmsMessageEntity({
    required final String id,
    required final String phoneNumber,
    required final String content,
    required final DateTime receivedAt,
    required final String sourceDeviceId,
    required final bool isRead,
    final String? contactName,
    required final SmsDirection direction,
  }) = _$SmsMessageEntityImpl;
  const _SmsMessageEntity._() : super._();

  @override
  String get id;
  @override
  String get phoneNumber;
  @override
  String get content;
  @override
  DateTime get receivedAt;
  @override
  String get sourceDeviceId;
  @override
  bool get isRead;
  @override
  String? get contactName;
  @override
  SmsDirection get direction;

  /// Create a copy of SmsMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsMessageEntityImplCopyWith<_$SmsMessageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
