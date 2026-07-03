import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/app/theme/colors.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/core/platform/gateway/providers/gateway_ui_bridge_provider.dart';
import 'package:dialcalink/features/pairing/presentation/providers/gateway_pairing_notifier.dart';
import 'package:dialcalink/features/pairing/presentation/providers/gateway_pairing_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GatewayPairingQrPhase extends ConsumerStatefulWidget {
  const GatewayPairingQrPhase({super.key});

  @override
  ConsumerState<GatewayPairingQrPhase> createState() =>
      _GatewayPairingQrPhaseState();
}

class _GatewayPairingQrPhaseState extends ConsumerState<GatewayPairingQrPhase> {
  final TextEditingController _ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeGenerate();
    });
  }

  void _maybeGenerate() {
    final state = ref.read(gatewayPairingNotifierProvider);
    if (state.phase == GatewayPairingPhase.idle) {
      final identity = ref.read(localDeviceIdentityProvider).value;
      if (identity != null) {
        ref
            .read(gatewayPairingNotifierProvider.notifier)
            .generate(
              gatewayDeviceId: identity.id,
              gatewayDeviceName: identity.name,
            );
      }
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pairingState = ref.watch(gatewayPairingNotifierProvider);
    final theme = Theme.of(context);

    ref.listen<GatewayPairingState>(gatewayPairingNotifierProvider, (prev, next) {
      if (next.phase == GatewayPairingPhase.showingQr && next.payload != null && next.payload?.pairingToken != prev?.payload?.pairingToken) {
        final bridge = ref.read(gatewayUiBridgeProvider);
        bridge.sendPairingToken(next.payload!.pairingToken);
      }
    });

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildPhaseContent(pairingState, theme),
    );
  }

  Widget _buildPhaseContent(GatewayPairingState state, ThemeData theme) {
    switch (state.phase) {
      case GatewayPairingPhase.idle:
      case GatewayPairingPhase.generating:
        return const _GeneratingPhase();
      case GatewayPairingPhase.showingQr:
        return _QrPhase(payloadJson: jsonEncode(state.payload?.toJson()));
      case GatewayPairingPhase.awaitingManualIp:
        return _ManualIpPhase(
          controller: _ipController,
          onSubmitted: (ip) {
            final identity = ref.read(localDeviceIdentityProvider).value;
            if (identity != null) {
              ref
                  .read(gatewayPairingNotifierProvider.notifier)
                  .generateWithManualIp(
                    gatewayDeviceId: identity.id,
                    gatewayDeviceName: identity.name,
                    manualIp: ip,
                  );
            }
          },
        );
      case GatewayPairingPhase.error:
        return _ErrorPhase(
          message: state.failure?.message ?? 'Ocurrió un error inesperado',
          onRetry: () {
            ref.read(gatewayPairingNotifierProvider.notifier).reset();
            _maybeGenerate();
          },
        );
    }
  }
}

class _GeneratingPhase extends StatelessWidget {
  const _GeneratingPhase();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      key: const ValueKey('generating'),
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.3, end: 0.8),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  CupertinoIcons.qrcode,
                  size: 100,
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Generando código QR...',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _QrPhase extends StatelessWidget {
  final String payloadJson;
  const _QrPhase({required this.payloadJson});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('showingQr'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: QrImageView(
            data: payloadJson,
            version: QrVersions.auto,
            size: 250.0,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Colors.black,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Listo para escanear',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}

class _ManualIpPhase extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const _ManualIpPhase({required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      key: const ValueKey('manualIp'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.5),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  CupertinoIcons.exclamationmark_triangle_fill,
                  color: AppColors.warning,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No se pudo detectar la IP de tu red local automáticamente. Por favor ingrésala manualmente.',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Dirección IP del dispositivo',
              hintText: 'Ej: 192.168.1.15',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(CupertinoIcons.wifi),
            ),
            keyboardType: TextInputType.number,
            onSubmitted: onSubmitted,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => controller.text.isEmpty ? null : onSubmitted(controller.text),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
              child: const Text('Generar QR con IP manual'),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ErrorPhase extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorPhase({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('error'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(CupertinoIcons.exclamationmark_circle_fill, color: Colors.red, size: 60),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(CupertinoIcons.refresh),
          label: const Text('Reintentar'),
        ),
      ],
    );
  }
}
