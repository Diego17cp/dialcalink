import 'package:notidialca/core/platform/gateway/providers/gateway_native_bridge_provider.dart';
import 'package:notidialca/core/platform/gateway/providers/gateway_ui_bridge_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_home_provider.g.dart';

enum GatewayServiceStatus { off, starting, on, stopping }

class GatewayHomeState {
  final GatewayServiceStatus serviceStatus;
  final bool isClientConnected;
  final String? clientDeviceId;

  GatewayHomeState({
    required this.serviceStatus,
    required this.isClientConnected,
    this.clientDeviceId,
  });

  GatewayHomeState copyWith({
    GatewayServiceStatus? serviceStatus,
    bool? isClientConnected,
    String? clientDeviceId,
  }) {
    return GatewayHomeState(
      serviceStatus: serviceStatus ?? this.serviceStatus,
      isClientConnected: isClientConnected ?? this.isClientConnected,
      clientDeviceId: clientDeviceId ?? this.clientDeviceId,
    );
  }
}

@riverpod
class GatewayHomeNotifier extends _$GatewayHomeNotifier {
  @override
  GatewayHomeState build() {
    final uiBridge = ref.watch(gatewayUiBridgeProvider);
    _checkServiceStatus();
    uiBridge.startListeningConnectionUpdates();
    ref.onDispose(() => uiBridge.stopListening());

    final subscription = uiBridge.connectionUpdates.listen((update) {
      state = state.copyWith(
        isClientConnected: update.isConnected,
        clientDeviceId: update.clientDeviceId,
      );
    });
    ref.onDispose(() => subscription.cancel());

    return GatewayHomeState(
      serviceStatus: GatewayServiceStatus.off,
      isClientConnected: false,
    );
  }

  Future<void> _checkServiceStatus() async {
    final nativeBridge = ref.read(gatewayNativeBridgeProvider);
    final isRunning = await nativeBridge.isServiceRunning();
    state = state.copyWith(
      serviceStatus: isRunning
          ? GatewayServiceStatus.on
          : GatewayServiceStatus.off,
    );
  }

  Future<void> toggleService() async {
    final nativeBridge = ref.read(gatewayNativeBridgeProvider);
    if (state.serviceStatus == GatewayServiceStatus.on) {
      state = state.copyWith(serviceStatus: GatewayServiceStatus.stopping);
      await nativeBridge.stopService();
      state = state.copyWith(
        serviceStatus: GatewayServiceStatus.off,
        isClientConnected: false,
        clientDeviceId: null,
      );
    } else {
      state = state.copyWith(serviceStatus: GatewayServiceStatus.starting);
      await nativeBridge.startService();
      state = state.copyWith(serviceStatus: GatewayServiceStatus.on);
    }
  }
}
