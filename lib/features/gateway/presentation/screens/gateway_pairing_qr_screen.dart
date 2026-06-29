import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notidialca/core/identity/providers/device_identity_provider.dart';
import 'package:notidialca/features/gateway/presentation/widgets/gateway_pairing_identity_failed.dart';
import 'package:notidialca/features/gateway/presentation/widgets/gateway_pairing_qr_phase.dart';
import 'package:notidialca/features/pairing/presentation/providers/gateway_pairing_notifier.dart';
import 'package:notidialca/features/pairing/presentation/providers/gateway_pairing_state.dart';

class GatewayPairingQrScreen extends ConsumerStatefulWidget {
  const GatewayPairingQrScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GatewayPairingQrScreenState();
}

class _GatewayPairingQrScreenState
    extends ConsumerState<GatewayPairingQrScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localDeviceIdentity = ref.watch(localDeviceIdentityProvider).value;
    final pairingState = ref.watch(gatewayPairingNotifierProvider);

    final canGoBack = pairingState.phase != GatewayPairingPhase.generating;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Dispositivo'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: canGoBack ? () => context.pop() : null,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      CupertinoIcons.link,
                      color: theme.colorScheme.primary,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Casi listo para conectar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Abre DialcaLink en tu dispositivo principal y escanea el código QR.',
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  if (localDeviceIdentity == null) ...const [
                    GatewayPairingIdentityFailed(),
                  ] else ...[
                    const GatewayPairingQrPhase(),
                  ],
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: canGoBack ? () => context.pop() : null,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Hecho'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (pairingState.phase == GatewayPairingPhase.showingQr)
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              ref
                                  .read(gatewayPairingNotifierProvider.notifier)
                                  .reset();
                              Future.delayed(const Duration(milliseconds: 500), () {
                                ref
                                    .read(gatewayPairingNotifierProvider.notifier)
                                    .generate(
                                      gatewayDeviceId:
                                          localDeviceIdentity?.id ?? '',
                                      gatewayDeviceName:
                                          localDeviceIdentity?.name ?? '',
                                    );
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              side: BorderSide(
                                color: theme.colorScheme.tertiary,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              foregroundColor: theme.colorScheme.tertiary,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.refresh, size: 18),
                                SizedBox(width: 8),
                                Text('Generar nuevo código'),
                              ],
                            ),
                          )
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
