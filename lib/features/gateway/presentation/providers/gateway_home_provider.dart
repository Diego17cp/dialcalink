import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/core/platform/gateway/providers/gateway_native_bridge_provider.dart';
import 'package:dialcalink/core/platform/gateway/providers/gateway_ui_bridge_provider.dart';
import 'package:dialcalink/features/calls/presentation/providers/call_providers.dart';
import 'package:dialcalink/features/sms/presentation/providers/sms_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_home_provider.g.dart';

enum GatewayServiceStatus { off, starting, on, stopping }

class GatewayHomeState {
  final GatewayServiceStatus serviceStatus;
  final bool isClientConnected;
  final String? clientDeviceId;
  final DateTime? serviceStartedAt;

  GatewayHomeState({
    required this.serviceStatus,
    required this.isClientConnected,
    this.clientDeviceId,
    this.serviceStartedAt,
  });

  GatewayHomeState copyWith({
    GatewayServiceStatus? serviceStatus,
    bool? isClientConnected,
    String? clientDeviceId,
    DateTime? serviceStartedAt,
  }) {
    return GatewayHomeState(
      serviceStatus: serviceStatus ?? this.serviceStatus,
      isClientConnected: isClientConnected ?? this.isClientConnected,
      clientDeviceId: clientDeviceId ?? this.clientDeviceId,
      serviceStartedAt: serviceStartedAt ?? this.serviceStartedAt,
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
    final identityService = await ref.read(deviceIdentityServiceProvider.future);
    final startedAt = await identityService.readServiceStartedAtAsync();
    state = state.copyWith(
      serviceStatus: isRunning
          ? GatewayServiceStatus.on
          : GatewayServiceStatus.off,
      serviceStartedAt: isRunning ? startedAt : null,
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
        serviceStartedAt: null,
      );
    } else {
      state = state.copyWith(serviceStatus: GatewayServiceStatus.starting);
      final nativeBridge = ref.read(gatewayNativeBridgeProvider);
      await nativeBridge.startService();
      await Future.delayed(const Duration(milliseconds: 500));
      await _checkServiceStatus();
    }
  }
}

// @riverpod
// Future<int> messagesTodayCount(Ref ref) async {
//   final identity = await ref.watch(localDeviceIdentityProvider.future);
//   if (identity == null) return 0;
  
//   final repository = ref.watch(smsRepositoryProvider);
//   final now = DateTime.now();
//   final startOfDay = DateTime(now.year, now.month, now.day);
  
//   return repository.countByDateAndId(startOfDay, identity.id);
// }

// @riverpod
// Future<int> callsTodayCount(Ref ref) async {
//   final identity = await ref.watch(localDeviceIdentityProvider.future);
//   if (identity == null) return 0;
  
//   final repository = ref.watch(callRepositoryProvider);
//   final now = DateTime.now();
//   final startOfDay = DateTime(now.year, now.month, now.day);
  
//   return repository.countByDateAndId(startOfDay, identity.id);
// }

@riverpod
Stream<int> messagesTodayCount(Ref ref) async* {
  final identity = await ref.watch(localDeviceIdentityProvider.future);
  if (identity == null) {
    yield 0;
    return;
  }
  final repository = ref.watch(smsRepositoryProvider);
  final now = DateTime.now();
  final startOfDay = DateTime(now.year, now.month, now.day);
  yield* repository.watchCountByDateAndId(startOfDay, identity.id);
}

@riverpod
Stream<int> callsTodayCount(Ref ref) async* {
  final identity = await ref.watch(localDeviceIdentityProvider.future);
  if (identity == null) {
    yield 0;
    return;
  }
  final repository = ref.watch(callRepositoryProvider);
  final now = DateTime.now();
  final startOfDay = DateTime(now.year, now.month, now.day);
  yield* repository.watchCountByDateAndId(startOfDay, identity.id);
}

@riverpod
Stream<Duration?> gatewayUptime(Ref ref) async* {
  final state = ref.watch(gatewayHomeNotifierProvider);
  final startedAt = state.serviceStartedAt;
  
  if (startedAt == null || state.serviceStatus != GatewayServiceStatus.on) {
    yield null;
    return;
  }

  while (true) {
    yield DateTime.now().difference(startedAt);
    await Future.delayed(const Duration(seconds: 1));
  }
}