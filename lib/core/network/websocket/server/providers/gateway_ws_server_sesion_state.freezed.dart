// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gateway_ws_server_sesion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GatewayWsServerSessionState {
  GatewayWsServerStatus get status => throw _privateConstructorUsedError;
  bool get hasConnectedClient => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of GatewayWsServerSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GatewayWsServerSessionStateCopyWith<GatewayWsServerSessionState>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GatewayWsServerSessionStateCopyWith<$Res> {
  factory $GatewayWsServerSessionStateCopyWith(
    GatewayWsServerSessionState value,
    $Res Function(GatewayWsServerSessionState) then,
  ) =
      _$GatewayWsServerSessionStateCopyWithImpl<
        $Res,
        GatewayWsServerSessionState
      >;
  @useResult
  $Res call({
    GatewayWsServerStatus status,
    bool hasConnectedClient,
    String? errorMessage,
  });
}

/// @nodoc
class _$GatewayWsServerSessionStateCopyWithImpl<
  $Res,
  $Val extends GatewayWsServerSessionState
>
    implements $GatewayWsServerSessionStateCopyWith<$Res> {
  _$GatewayWsServerSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GatewayWsServerSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? hasConnectedClient = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GatewayWsServerStatus,
            hasConnectedClient: null == hasConnectedClient
                ? _value.hasConnectedClient
                : hasConnectedClient // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GatewayWsServerSessionStateImplCopyWith<$Res>
    implements $GatewayWsServerSessionStateCopyWith<$Res> {
  factory _$$GatewayWsServerSessionStateImplCopyWith(
    _$GatewayWsServerSessionStateImpl value,
    $Res Function(_$GatewayWsServerSessionStateImpl) then,
  ) = __$$GatewayWsServerSessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GatewayWsServerStatus status,
    bool hasConnectedClient,
    String? errorMessage,
  });
}

/// @nodoc
class __$$GatewayWsServerSessionStateImplCopyWithImpl<$Res>
    extends
        _$GatewayWsServerSessionStateCopyWithImpl<
          $Res,
          _$GatewayWsServerSessionStateImpl
        >
    implements _$$GatewayWsServerSessionStateImplCopyWith<$Res> {
  __$$GatewayWsServerSessionStateImplCopyWithImpl(
    _$GatewayWsServerSessionStateImpl _value,
    $Res Function(_$GatewayWsServerSessionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GatewayWsServerSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? hasConnectedClient = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$GatewayWsServerSessionStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GatewayWsServerStatus,
        hasConnectedClient: null == hasConnectedClient
            ? _value.hasConnectedClient
            : hasConnectedClient // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GatewayWsServerSessionStateImpl
    implements _GatewayWsServerSessionState {
  const _$GatewayWsServerSessionStateImpl({
    this.status = GatewayWsServerStatus.stopped,
    this.hasConnectedClient = false,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final GatewayWsServerStatus status;
  @override
  @JsonKey()
  final bool hasConnectedClient;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'GatewayWsServerSessionState(status: $status, hasConnectedClient: $hasConnectedClient, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GatewayWsServerSessionStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hasConnectedClient, hasConnectedClient) ||
                other.hasConnectedClient == hasConnectedClient) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, hasConnectedClient, errorMessage);

  /// Create a copy of GatewayWsServerSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GatewayWsServerSessionStateImplCopyWith<_$GatewayWsServerSessionStateImpl>
  get copyWith =>
      __$$GatewayWsServerSessionStateImplCopyWithImpl<
        _$GatewayWsServerSessionStateImpl
      >(this, _$identity);
}

abstract class _GatewayWsServerSessionState
    implements GatewayWsServerSessionState {
  const factory _GatewayWsServerSessionState({
    final GatewayWsServerStatus status,
    final bool hasConnectedClient,
    final String? errorMessage,
  }) = _$GatewayWsServerSessionStateImpl;

  @override
  GatewayWsServerStatus get status;
  @override
  bool get hasConnectedClient;
  @override
  String? get errorMessage;

  /// Create a copy of GatewayWsServerSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GatewayWsServerSessionStateImplCopyWith<_$GatewayWsServerSessionStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
