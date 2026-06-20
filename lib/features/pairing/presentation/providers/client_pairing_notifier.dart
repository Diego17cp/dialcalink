import 'package:notidialca/core/failures/pairing_failure.dart';
import 'package:notidialca/features/pairing/domain/entities/pairing_attempt.dart';
import 'package:notidialca/features/pairing/presentation/providers/client_pairing_state.dart';
import 'package:notidialca/features/pairing/presentation/providers/pairing_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_pairing_notifier.g.dart';

@riverpod
class ClientPairingNotifier extends _$ClientPairingNotifier {
  @override
  ClientPairingState build() => const ClientPairingState();

  Future<void> onCodeScanned(String rawValue) async {
    if (state.phase != ClientPairingPhase.scanning &&
        state.phase != ClientPairingPhase.invalidQr) {
      return;
    }

    final PairingAttempt? attempt;

    try {
      final decodeUseCase = await ref.read(decodeScannedPairingPayloadUseCaseProvider.future);
      attempt = decodeUseCase.call(rawValue);
    } catch (e) {
      state = state.copyWith(
        phase: ClientPairingPhase.failed,
        failure: PairingConnectionFailure(
          'No se pudo iniciar la verificacion: ${e.toString()}',
        ),
      );
      return;
    }

    if (attempt == null) {
      state = state.copyWith(phase: ClientPairingPhase.invalidQr);
      return;
    }
    state = state.copyWith(
      phase: ClientPairingPhase.verifying,
      attempt: attempt,
      failure: null,
    );
    final confirmUseCase = await ref.read(confirmPairingUseCaseProvider.future);
    final result = await confirmUseCase.call(attempt);

    result.when(
      ok: (device) {
        state = state.copyWith(
          phase: ClientPairingPhase.linked,
          linkedDevice: device,
        );
      },
      failure: (failure) {
        state = state.copyWith(
          phase: ClientPairingPhase.failed,
          failure: failure is PairingFailure ? failure : null,
        );
      },
    );
  }

  void retry() {
    state = const ClientPairingState();
  }
}
