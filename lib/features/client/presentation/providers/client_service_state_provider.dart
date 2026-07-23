import 'package:dialcalink/core/platform/client/providers/client_native_bridge_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_service_state_provider.g.dart';

@riverpod
Future<bool> clientServiceRunning(Ref ref) => ref.watch(clientNativeBridgeProvider).isClientServiceRunning();

@riverpod
class ClientServiceRestartController extends _$ClientServiceRestartController {
  @override
  FutureOr<void> build() {}

  Future<void> restart() async {
    state = const AsyncLoading();
    final bridge = ref.read(clientNativeBridgeProvider);
    state = await AsyncValue.guard(() async {
      await bridge.stopClientService();
      await Future.delayed(const Duration(milliseconds: 500));
      await bridge.startClientService();
    });
    ref.invalidate(clientServiceRunningProvider);
  }
}