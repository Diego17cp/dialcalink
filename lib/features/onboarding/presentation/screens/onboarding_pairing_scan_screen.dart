import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:dialcalink/features/onboarding/presentation/widgets/pairing_scanner_overlay.dart';
import 'package:dialcalink/features/onboarding/presentation/widgets/pairing_status_card.dart';
import 'package:dialcalink/features/onboarding/presentation/widgets/pairing_success_view.dart';
import 'package:dialcalink/features/pairing/presentation/providers/client_pairing_notifier.dart';
import 'package:dialcalink/features/pairing/presentation/providers/client_pairing_state.dart';
import 'package:dialcalink/shared/glass_icon_button.dart';

class PairingScanScreen extends ConsumerStatefulWidget {
  const PairingScanScreen({super.key});

  @override
  ConsumerState<PairingScanScreen> createState() => _PairingScanScreenState();
}

class _PairingScanScreenState extends ConsumerState<PairingScanScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _hasNavigated = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue != null) {
      ref
          .read(clientPairingNotifierProvider.notifier)
          .onCodeScanned(barcode!.rawValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clientPairingNotifierProvider);
    final isLinked = state.phase == ClientPairingPhase.linked;

    if (isLinked && !_hasNavigated) {
      _hasNavigated = true;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) context.go('/client/sms');
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          PairingScannerOverlay(isSuccess: isLinked),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GlassIconButton(
                  icon: CupertinoIcons.back,
                  onTap: () => context.pop(),
                ),
                const Expanded(
                  child: Text(
                    'Vincular dispositivo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: PairingStatusCard(
              phase: state.phase,
              errorMessage: state.failure?.message,
            )
          ),
          if (isLinked) 
            Container(
              color: Colors.black87,
              child: const PairingSuccessView(),
            )
        ],
      ),
    );
  }
}
