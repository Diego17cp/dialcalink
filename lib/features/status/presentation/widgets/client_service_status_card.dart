import 'package:dialcalink/app/theme/colors.dart';
import 'package:dialcalink/core/platform/client/native/client_ui_bridge.dart';
import 'package:dialcalink/core/platform/client/providers/client_connection_state_provider.dart';
import 'package:dialcalink/core/platform/client/providers/client_native_bridge_provider.dart';
import 'package:dialcalink/features/client/presentation/providers/client_service_state_provider.dart';
import 'package:dialcalink/features/gateway/presentation/widgets/gateway_home_status_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientServiceStatusCard extends ConsumerStatefulWidget {
  const ClientServiceStatusCard({super.key});

  @override
  ConsumerState<ClientServiceStatusCard> createState() => _ClientServiceStatusCardState();
}

class _ClientServiceStatusCardState extends ConsumerState<ClientServiceStatusCard> {
  bool _isToggling = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stateAsync = ref.watch(clientServiceRunningProvider);
    final connectionAsync = ref.watch(clientConnectionStateProvider);

    return stateAsync.when(
      data: (isRunning) {
        final connectionState = connectionAsync.valueOrNull?.state ?? ClientConnectionStateBridge.disconnected;
        final isConnected = connectionState == ClientConnectionStateBridge.ready;
        final isConnecting = connectionState == ClientConnectionStateBridge.connecting ||
            connectionState == ClientConnectionStateBridge.reconnecting ||
            connectionState == ClientConnectionStateBridge.connected;

        Color statusColor = AppColors.disconnected;
        String statusTitle = 'Servicio Desconectado';
        String statusSubtitle = 'El servicio de cliente no se encuentra activo.';
        IconData statusIcon = CupertinoIcons.power;

        if (isRunning) {
          if (isConnected) {
            statusColor = AppColors.connected;
            statusTitle = 'Servicio Activo';
            statusSubtitle = 'Sincronizando con el Gateway.';
            statusIcon = CupertinoIcons.arrow_2_circlepath;
          } else if (isConnecting) {
            statusColor = AppColors.connecting;
            statusTitle = 'Estableciendo Conexión...';
            statusSubtitle = 'El servicio está buscando el Gateway.';
            statusIcon = CupertinoIcons.dot_radiowaves_left_right;
          } else {
            statusColor = AppColors.connecting;
            statusTitle = 'Esperando Gateway...';
            statusSubtitle = 'El servicio de cliente está activo pero desconectado.';
            statusIcon = CupertinoIcons.wifi_slash;
          }
        }

        return Card(
          elevation: 0,
          color: statusColor.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: statusColor.withValues(alpha: 0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    GatewayHomeStatusIndicator(
                      color: statusColor,
                      isAnimated: isRunning && !isConnected,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statusTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: statusColor.withValues(alpha: 0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(statusSubtitle, style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    Icon(statusIcon, color: statusColor),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _isToggling
                        ? null
                        : () async {
                            setState(() {
                              _isToggling = true;
                            });
                            try {
                              final bridge = ref.read(clientNativeBridgeProvider);
                              if (isRunning) {
                                await bridge.stopClientService();
                              } else {
                                await bridge.startClientService();
                              }
                              ref.invalidate(clientServiceRunningProvider);
                              await ref.read(clientServiceRunningProvider.future);
                            } catch (_) {
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isToggling = false;
                                });
                              }
                            }
                          },
                    label: Text(
                      isRunning ? 'Detener Servicio' : 'Iniciar Servicio',
                    ),
                    icon: _isToggling
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            isRunning
                                ? CupertinoIcons.stop_fill
                                : CupertinoIcons.play_fill,
                          ),
                    style: FilledButton.styleFrom(
                      backgroundColor: isRunning
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estado del Servicio del Cliente',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Verificando...',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stack) => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: theme.colorScheme.error.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Error al obtener estado',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      error.toString(),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
