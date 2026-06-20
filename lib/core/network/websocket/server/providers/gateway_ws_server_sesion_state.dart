import 'package:freezed_annotation/freezed_annotation.dart';

import '../gateway_ws_server.dart';

part 'gateway_ws_server_sesion_state.freezed.dart';

@freezed
class GatewayWsServerSessionState with _$GatewayWsServerSessionState {
  const factory GatewayWsServerSessionState({
    @Default(GatewayWsServerStatus.stopped) GatewayWsServerStatus status,
    @Default(false) bool hasConnectedClient,
    String? errorMessage,
  }) = _GatewayWsServerSessionState;
}