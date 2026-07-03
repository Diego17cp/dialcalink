import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notidialca/core/identity/providers/device_identity_provider.dart';
import 'package:notidialca/core/network/websocket/client/providers/gateway_ws_client_notifier.dart';
import 'package:notidialca/core/network/websocket/client/ws_connection_state.dart';
import 'package:notidialca/features/devices/domain/entities/device_entity.dart';
import 'package:notidialca/features/devices/presentation/providers/device_providers.dart';
import 'package:notidialca/features/gateway/presentation/utils/formatters.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final connectionState = ref.watch(gatewayWsClientNotifierProvider);

    final linkedDevicesAsync = ref.watch(linkedDevicesProvider);
    final gateway = linkedDevicesAsync.valueOrNull?.firstOrNull;

    final (statusLabel, statusColor, statusIcon) = switch (connectionState) {
      WsReady() => ('Conectado', Colors.green, CupertinoIcons.wifi),
      WsConnecting() => ('Conectando...', Colors.orange, CupertinoIcons.wifi),
      WsReconnecting() => (
        'Reconectando...',
        Colors.orange,
        CupertinoIcons.wifi,
      ),
      WsHandshakeRejected() => (
        'Vínculo perdido',
        Colors.red,
        CupertinoIcons.wifi_exclamationmark,
      ),
      WsDisconnected() => (
        'Desconectado',
        Colors.grey,
        CupertinoIcons.wifi_slash,
      ),
      WsConnected() => ('Autenticando...', Colors.orange, CupertinoIcons.wifi),
      WsError() => (
        'Error de conexión',
        Colors.red,
        CupertinoIcons.exclamationmark_circle,
      ),
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            color: statusColor.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: statusColor.withValues(alpha: 0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(statusIcon, color: statusColor, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estado del Servicio',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          statusLabel,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Información del Gateway',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          if (gateway != null) ...[
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant.withValues(
                    alpha: 0.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: CupertinoIcons.device_phone_portrait,
                      label: 'Dispositivo',
                      value: gateway.deviceName,
                    ),
                    const Divider(height: 32),
                    _InfoRow(
                      icon: CupertinoIcons.antenna_radiowaves_left_right,
                      label: 'Dirección IP',
                      value: gateway.lastKnownIp ?? 'Desconocida',
                    ),
                    const Divider(height: 32),
                    _InfoRow(
                      icon: CupertinoIcons.clock,
                      label: 'Última sincronización',
                      value: formatDateTime(gateway.lastSeenAt),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (connectionState is WsHandshakeRejected || connectionState is WsError)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => context.push('/client/re-pair'),
                    icon: const Icon(CupertinoIcons.link),
                    label: const Text('Re-vincular Dispositivo'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            if (connectionState is WsReconnecting ||
                connectionState is WsDisconnected ||
                connectionState is WsError)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _forceReconnect(ref, gateway),
                    icon: const Icon(CupertinoIcons.refresh, size: 18),
                    label: const Text('Forzar reconexión'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showForgetDialog(context, ref, gateway.id),
                icon: const Icon(CupertinoIcons.trash, size: 18),
                label: const Text('Olvidar este Gateway'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(
                    color: theme.colorScheme.error.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ] else
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    const Text('No hay ningún Gateway vinculado.'),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => context.push('/client/re-pair'),
                          icon: const Icon(CupertinoIcons.link),
                          label: const Text('Vincular Dispositivo'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
            ),
        ],
      ),
    );
  }

  Future<void> _showForgetDialog(
    BuildContext context,
    WidgetRef ref,
    String gatewayId,
  ) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('¿Olvidar Gateway?'),
        content: const Text(
          'Se perderá la conexión y tendrás que vincularlo nuevamente para recibir SMS y llamadas.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Olvidar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(gatewayWsClientNotifierProvider.notifier).disconnect();
      final result = await ref
          .read(deviceRepositoryProvider)
          .revokeDevice(gatewayId);
      if (result.isFailure) {
        return;
      }
      ref.invalidate(linkedDevicesProvider);

      if (context.mounted) {
        context.push('/onboarding/pairing-scan');
      }
    }
  }

  void _forceReconnect(WidgetRef ref, DeviceEntity gateway) {
    final identity = ref.read(localDeviceIdentityProvider).valueOrNull;
    if (identity == null) return;

    ref.read(gatewayWsClientNotifierProvider.notifier).disconnect();
    ref
        .read(gatewayWsClientNotifierProvider.notifier)
        .connect(
          ip: gateway.lastKnownIp ?? '',
          port: gateway.lastKnownPort ?? 8888,
          clientDeviceId: identity.id,
        );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
