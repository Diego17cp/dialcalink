import 'package:dialcalink/core/failures/pairing_failure.dart';
import 'package:dialcalink/features/pairing/presentation/providers/gateway_pairing_state.dart';
import 'package:dialcalink/features/pairing/presentation/providers/pairing_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_pairing_notifier.g.dart';

@riverpod
class GatewayPairingNotifier extends _$GatewayPairingNotifier {
  @override
  GatewayPairingState build() => const GatewayPairingState();

  Future<void> generate({
    required String gatewayDeviceId,
    required String gatewayDeviceName,
  }) async {
    state = state.copyWith(
      phase: GatewayPairingPhase.generating,
      failure: null,
    );
    final useCase = ref.read(generateGatewayPairingPayloadUseCaseProvider);
    final result = await useCase(
      gatewayDeviceId: gatewayDeviceId,
      gatewayDeviceName: gatewayDeviceName,
    );
    result.when(
      ok: (payload) {
        state = state.copyWith(
          phase: GatewayPairingPhase.showingQr,
          payload: payload,
        );
      },
      failure: (failure) {
        final isNetworkInfoIssue = failure is PairingNetworkInfoFailure;
        state = state.copyWith(
          phase: isNetworkInfoIssue
            ? GatewayPairingPhase.awaitingManualIp
            : GatewayPairingPhase.error,
          failure: failure is PairingFailure ? failure : null,
        );
      }
    );
  }
  void generateWithManualIp({
    required String gatewayDeviceId,
    required String gatewayDeviceName,
    required String manualIp,
  }) {
    final useCase = ref.read(generateGatewayPairingPayloadUseCaseProvider);
    final payload = useCase.callWithManualIp(
      gatewayDeviceId: gatewayDeviceId,
      gatewayDeviceName: gatewayDeviceName,
      manualIp: manualIp,
    );
    state = state.copyWith(
      phase: GatewayPairingPhase.showingQr,
      payload: payload,
      failure: null,
    );
  }
  void reset() {
    state = const GatewayPairingState();
  }
}