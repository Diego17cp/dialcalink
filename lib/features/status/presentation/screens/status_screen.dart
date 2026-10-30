import 'package:dialcalink/app/ui/widgets/update_check_button.dart';
import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:dialcalink/core/platform/client/native/client_ui_bridge.dart';
import 'package:dialcalink/core/platform/client/providers/client_connection_state_provider.dart';
import 'package:dialcalink/core/platform/client/providers/client_native_bridge_provider.dart';
import 'package:dialcalink/core/platform/client/providers/client_storage_provider.dart';
import 'package:dialcalink/core/platform/client/providers/client_ui_bridge_provider.dart';
import 'package:dialcalink/features/status/presentation/widgets/client_service_status_card.dart';
import 'package:dialcalink/features/status/presentation/widgets/gateway_info_row.dart';
import 'package:dialcalink/features/status/presentation/widgets/status_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dialcalink/features/devices/domain/entities/device_entity.dart';
import 'package:dialcalink/features/devices/presentation/providers/device_providers.dart';
import 'package:dialcalink/features/gateway/presentation/utils/formatters.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final connectionAsync = ref.watch(clientConnectionStateProvider);
    final connectionState =
        connectionAsync.valueOrNull?.state ??
        ClientConnectionStateBridge.disconnected;
    // final connectionState = ref.watch(gatewayWsClientNotifierProvider);

    final linkedDevicesAsync = ref.watch(linkedDevicesProvider);
    final gateway = linkedDevicesAsync.valueOrNull?.firstOrNull;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UpdateCheckButton(),
            const SizedBox(height: 12),
            const ClientServiceStatusCard(),
            const SizedBox(height: 24),
            Text(
              l10n.clientStatusInfo,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            StatusCard(connectionState: connectionState),
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
                      GatewayInfoRow(
                        icon: CupertinoIcons.device_phone_portrait,
                        label: l10n.clientStatusDevice,
                        value: gateway.deviceName,
                      ),
                      const Divider(height: 32),
                      GatewayInfoRow(
                        icon: CupertinoIcons.antenna_radiowaves_left_right,
                        label: l10n.clientStatusIP,
                        value: gateway.lastKnownIp ?? l10n.unknown,
                      ),
                      const Divider(height: 32),
                      GatewayInfoRow(
                        icon: CupertinoIcons.clock,
                        label: l10n.clientStatusLastSync,
                        value: formatDateTime(gateway.lastSeenAt),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              if (connectionState ==
                      ClientConnectionStateBridge.handshakeRejected ||
                  connectionState == ClientConnectionStateBridge.error)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => context.push('/client/re-pair'),
                      icon: const Icon(CupertinoIcons.link),
                      label: Text(l10n.clientStatusBtnReSync),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              if (connectionState == ClientConnectionStateBridge.reconnecting ||
                  connectionState == ClientConnectionStateBridge.disconnected ||
                  connectionState == ClientConnectionStateBridge.error)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _forceReconnect(ref, gateway),
                      icon: const Icon(CupertinoIcons.refresh, size: 18),
                      label: Text(l10n.clientStatusBtnForceSync),
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
                  label: Text(l10n.clientStatusBtnForgot),
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
                      Text(l10n.clientStatusEmptyTitle),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () => context.push('/client/re-pair'),
                            icon: const Icon(CupertinoIcons.link),
                            label: Text(l10n.clientStatusSync),
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
      ),
    );
  }

  Future<void> _showForgetDialog(
    BuildContext context,
    WidgetRef ref,
    String gatewayId,
  ) async {
    final l10n = context.l10n;
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.clientStatusForgotDialogTitle),
        content: Text(l10n.clientStatusForgotDialogInfo),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.clientStatusForgotDialogBtnCancel),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.clientStatusForgotDialogBtnForgot),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(clientUiBridgeProvider).requestDisconnect();
      await ref.read(clientNativeBridgeProvider).stopClientService();
      final result = await ref
          .read(deviceRepositoryProvider)
          .revokeDevice(gatewayId);
      if (result.isFailure) return;
      final storage = await ref.read(clientStorageProvider.future);
      await storage.setHasLinkedGateway(false);

      ref.invalidate(linkedDevicesProvider);

      if (context.mounted) {
        context.push('/onboarding/pairing-scan');
      }
    }
  }

  void _forceReconnect(WidgetRef ref, DeviceEntity gateway) {
    ref.read(clientUiBridgeProvider).requestReconnect();
  }
}
