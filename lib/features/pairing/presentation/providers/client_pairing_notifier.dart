import 'package:dialcalink/core/failures/pairing_failure.dart';
import 'package:dialcalink/features/pairing/domain/entities/pairing_attempt.dart';
import 'package:dialcalink/features/pairing/presentation/providers/client_pairing_state.dart';
import 'package:dialcalink/features/pairing/presentation/providers/pairing_providers.dart';
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
    try {
      final confirmUseCase = await ref.read(confirmPairingUseCaseProvider.future);
      final result = await confirmUseCase.call(attempt);

      result.when(
        ok: (device) {
          if (state.phase == ClientPairingPhase.verifying) {
            state = state.copyWith(
              phase: ClientPairingPhase.linked,
              linkedDevice: device,
            );
          }
        },
        failure: (failure) {
          print('DIALCA_ERROR: Failure during pairing confirm: $failure');
          state = state.copyWith(
            phase: ClientPairingPhase.failed,
            failure: failure is PairingFailure ? failure : null,
          );
        },
      );
    } catch (e) {
      print('DIALCA_ERROR: Catch during pairing: $e');
      state = state.copyWith(phase: ClientPairingPhase.failed);
    }
  }

  void retry() {
    state = const ClientPairingState();
  }
}
