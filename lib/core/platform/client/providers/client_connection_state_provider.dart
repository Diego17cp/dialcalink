import 'package:dialcalink/core/platform/client/native/client_ui_bridge.dart';
import 'package:dialcalink/core/platform/client/providers/client_ui_bridge_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_connection_state_provider.g.dart';

@riverpod
Stream<ClientConnectionStateUpdate> clientConnectionState(Ref ref) {
  final bridge = ref.watch(clientUiBridgeProvider);
  bridge.startListeningFromUi();
  return bridge.connectionStateUpdate;
}