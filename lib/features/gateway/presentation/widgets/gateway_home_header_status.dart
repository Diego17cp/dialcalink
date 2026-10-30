import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/app/theme/colors.dart';
import 'package:dialcalink/features/devices/presentation/providers/device_providers.dart';
import 'package:dialcalink/features/gateway/presentation/providers/gateway_home_provider.dart';
import 'package:dialcalink/features/gateway/presentation/widgets/gateway_home_status_indicator.dart';

class GatewayHomeHeaderStatus extends ConsumerWidget {
  const GatewayHomeHeaderStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gatewayHomeNotifierProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final isRunning = state.serviceStatus == GatewayServiceStatus.on;
    final isConnected = state.isClientConnected;
    final clientId = state.clientDeviceId;

    final connectedDeviceAsync = clientId != null
      ? ref.watch(deviceByIdProvider(clientId))
      : const AsyncValue.data(null);

    Color statusColor = AppColors.disconnected;
    String statusTitle = l10n.gatewayStatusTitleDisconnected;
    String statusSubtitle = l10n.gatewayStatusSubtitleDisconnected;
    IconData statusIcon = CupertinoIcons.power;

    if (isRunning) {
      if (isConnected) {
        statusColor = AppColors.connected;
        statusTitle = l10n.gatewayStatusTitleConnected;
        final deviceName = connectedDeviceAsync.valueOrNull?.deviceName ?? clientId ?? l10n.unknown;
        statusSubtitle =
            '${l10n.gatewayStatusSubtitleConnected} $deviceName.';
        statusIcon = CupertinoIcons.arrow_2_circlepath;
      } else {
        statusColor = AppColors.connecting;
        statusTitle = l10n.gatewayStatusTitleConnecting;
        statusSubtitle = l10n.gatewayStatusSubtitleConnecting;
        statusIcon = CupertinoIcons.dot_radiowaves_left_right;
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
                onPressed: () => ref
                    .read(gatewayHomeNotifierProvider.notifier)
                    .toggleService(),
                label: Text(
                  isRunning ? l10n.stopService : l10n.startService,
                ),
                icon:
                    state.serviceStatus == GatewayServiceStatus.starting ||
                        state.serviceStatus == GatewayServiceStatus.stopping
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
  }
}
