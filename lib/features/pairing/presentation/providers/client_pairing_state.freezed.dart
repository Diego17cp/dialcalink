// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_pairing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClientPairingState {
  ClientPairingPhase get phase => throw _privateConstructorUsedError;
  PairingAttempt? get attempt => throw _privateConstructorUsedError;
  DeviceEntity? get linkedDevice => throw _privateConstructorUsedError;
  PairingFailure? get failure => throw _privateConstructorUsedError;

  /// Create a copy of ClientPairingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientPairingStateCopyWith<ClientPairingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientPairingStateCopyWith<$Res> {
  factory $ClientPairingStateCopyWith(
    ClientPairingState value,
    $Res Function(ClientPairingState) then,
  ) = _$ClientPairingStateCopyWithImpl<$Res, ClientPairingState>;
  @useResult
  $Res call({
    ClientPairingPhase phase,
    PairingAttempt? attempt,
    DeviceEntity? linkedDevice,
    PairingFailure? failure,
  });

  $PairingAttemptCopyWith<$Res>? get attempt;
  $DeviceEntityCopyWith<$Res>? get linkedDevice;
}

/// @nodoc
class _$ClientPairingStateCopyWithImpl<$Res, $Val extends ClientPairingState>
    implements $ClientPairingStateCopyWith<$Res> {
  _$ClientPairingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientPairingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? attempt = freezed,
    Object? linkedDevice = freezed,
    Object? failure = freezed,
  }) {
    return _then(
      _value.copyWith(
            phase: null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as ClientPairingPhase,
            attempt: freezed == attempt
                ? _value.attempt
                : attempt // ignore: cast_nullable_to_non_nullable
                      as PairingAttempt?,
            linkedDevice: freezed == linkedDevice
                ? _value.linkedDevice
                : linkedDevice // ignore: cast_nullable_to_non_nullable
                      as DeviceEntity?,
            failure: freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                      as PairingFailure?,
          )
          as $Val,
    );
  }

  /// Create a copy of ClientPairingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PairingAttemptCopyWith<$Res>? get attempt {
    if (_value.attempt == null) {
      return null;
    }

    return $PairingAttemptCopyWith<$Res>(_value.attempt!, (value) {
      return _then(_value.copyWith(attempt: value) as $Val);
    });
  }

  /// Create a copy of ClientPairingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceEntityCopyWith<$Res>? get linkedDevice {
    if (_value.linkedDevice == null) {
      return null;
    }

    return $DeviceEntityCopyWith<$Res>(_value.linkedDevice!, (value) {
      return _then(_value.copyWith(linkedDevice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientPairingStateImplCopyWith<$Res>
    implements $ClientPairingStateCopyWith<$Res> {
  factory _$$ClientPairingStateImplCopyWith(
    _$ClientPairingStateImpl value,
    $Res Function(_$ClientPairingStateImpl) then,
  ) = __$$ClientPairingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ClientPairingPhase phase,
    PairingAttempt? attempt,
    DeviceEntity? linkedDevice,
    PairingFailure? failure,
  });

  @override
  $PairingAttemptCopyWith<$Res>? get attempt;
  @override
  $DeviceEntityCopyWith<$Res>? get linkedDevice;
}

/// @nodoc
class __$$ClientPairingStateImplCopyWithImpl<$Res>
    extends _$ClientPairingStateCopyWithImpl<$Res, _$ClientPairingStateImpl>
    implements _$$ClientPairingStateImplCopyWith<$Res> {
  __$$ClientPairingStateImplCopyWithImpl(
    _$ClientPairingStateImpl _value,
    $Res Function(_$ClientPairingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientPairingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? attempt = freezed,
    Object? linkedDevice = freezed,
    Object? failure = freezed,
  }) {
    return _then(
      _$ClientPairingStateImpl(
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as ClientPairingPhase,
        attempt: freezed == attempt
            ? _value.attempt
            : attempt // ignore: cast_nullable_to_non_nullable
                  as PairingAttempt?,
        linkedDevice: freezed == linkedDevice
            ? _value.linkedDevice
            : linkedDevice // ignore: cast_nullable_to_non_nullable
                  as DeviceEntity?,
        failure: freezed == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as PairingFailure?,
      ),
    );
  }
}

/// @nodoc

class _$ClientPairingStateImpl implements _ClientPairingState {
  const _$ClientPairingStateImpl({
    this.phase = ClientPairingPhase.scanning,
    this.attempt,
    this.linkedDevice,
    this.failure,
  });

  @override
  @JsonKey()
  final ClientPairingPhase phase;
  @override
  final PairingAttempt? attempt;
  @override
  final DeviceEntity? linkedDevice;
  @override
  final PairingFailure? failure;

  @override
  String toString() {
    return 'ClientPairingState(phase: $phase, attempt: $attempt, linkedDevice: $linkedDevice, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientPairingStateImpl &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.attempt, attempt) || other.attempt == attempt) &&
            (identical(other.linkedDevice, linkedDevice) ||
                other.linkedDevice == linkedDevice) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phase, attempt, linkedDevice, failure);

  /// Create a copy of ClientPairingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientPairingStateImplCopyWith<_$ClientPairingStateImpl> get copyWith =>
      __$$ClientPairingStateImplCopyWithImpl<_$ClientPairingStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ClientPairingState implements ClientPairingState {
  const factory _ClientPairingState({
    final ClientPairingPhase phase,
    final PairingAttempt? attempt,
    final DeviceEntity? linkedDevice,
    final PairingFailure? failure,
  }) = _$ClientPairingStateImpl;

  @override
  ClientPairingPhase get phase;
  @override
  PairingAttempt? get attempt;
  @override
  DeviceEntity? get linkedDevice;
  @override
  PairingFailure? get failure;

  /// Create a copy of ClientPairingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientPairingStateImplCopyWith<_$ClientPairingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
