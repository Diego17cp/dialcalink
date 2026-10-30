import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dialcalink/app/layouts/glass_scaffold.dart';
import 'package:dialcalink/core/database/drift/tables/devices_table.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/core/network/discovery/local_network_info_provider.dart';
import 'package:dialcalink/core/network/discovery/network_info_result.dart';
import 'package:dialcalink/core/permissions/app_permission.dart';
import 'package:dialcalink/core/permissions/providers/permissions_provider.dart';
import 'package:flutter/widget_previews.dart';
import 'package:dialcalink/core/platform/gateway/native/gateway_native_bridge.dart';
import 'package:dialcalink/core/platform/gateway/providers/gateway_native_bridge_provider.dart';
import 'package:dialcalink/features/onboarding/presentation/widgets/gateway_setup_device_item.dart';
import 'package:dialcalink/features/onboarding/presentation/widgets/gateway_setup_hotspot_item.dart';
import 'package:dialcalink/features/onboarding/presentation/widgets/gateway_setup_permissions_item.dart';

@Preview(name: 'Onboarding - Configuración de Gateway', group: 'Onboarding')
Widget previewOnboardingGatewaySetup() {
  return const MaterialApp(home: GatewaySetupScreen());
}

enum GatewaySetupStep { idle, starting, confirming, error }

class GatewaySetupScreen extends ConsumerStatefulWidget {
  const GatewaySetupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GatewaySetupScreenState();
}

class _GatewaySetupScreenState extends ConsumerState<GatewaySetupScreen> {
  bool isIdentityExpanded = false;
  GatewaySetupStep _step = GatewaySetupStep.idle;
  String? _errorMessage;

  static const int _maxPollingAttempts = 6;
  static const Duration _pollingInterval = Duration(milliseconds: 800);

  void _toggleIdentityExpanded() =>
      setState(() => isIdentityExpanded = !isIdentityExpanded);
  Future<void> _onFinishSetup(bool permissionsGranted) async {
    final l10n = context.l10n;
    if (!permissionsGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.onboardingGatewaySetupGrantPermissionsError),
        ),
      );
      return;
    }
    setState(() {
      _step = GatewaySetupStep.starting;
      _errorMessage = null;
    });
    final bridge = ref.read(gatewayNativeBridgeProvider);
    try {
      await bridge.startService();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _step = GatewaySetupStep.error;
        _errorMessage = '${context.l10n.onboardingGatewaySetupError} $e';
      });
      return;
    }
    setState(() {
      _step = GatewaySetupStep.confirming;
    });
    final confirmed = await _pollForServiceRunning(bridge);
    if (!mounted) return;
    if (confirmed) {
      context.go('/gateway/home');
    } else {
      setState(() {
        _step = GatewaySetupStep.error;
        _errorMessage = context.l10n.onboardingGatewayInactive;
      });
    }
  }

  Future<bool> _pollForServiceRunning(GatewayNativeBridge bridge) async {
    for (int i = 0; i < _maxPollingAttempts; i++) {
      await Future.delayed(_pollingInterval);
      if (!mounted) return false;
      final isRunning = await bridge.isServiceRunning();
      if (isRunning) {
        return true;
      }
    }
    return false;
  }

  bool get _isLoading =>
      _step == GatewaySetupStep.starting ||
      _step == GatewaySetupStep.confirming;

  String get _statusMessage { 
    final l10n = context.l10n;
    return switch (_step) {
    GatewaySetupStep.idle => '',
    GatewaySetupStep.starting => l10n.onboardingGatewayStarting,
    GatewaySetupStep.confirming => l10n.onboardingGatewayConfirming,
    GatewaySetupStep.error => _errorMessage ?? l10n.unknownError,
  };}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final identityAsync = ref.watch(localDeviceIdentityProvider);
    final l10n = context.l10n;

    return GlassScaffold(
      onBackTap: () => context.pop(),
      title: l10n.onboardingGatewaySetupAppbarTitle,
      body: SafeArea(
        child: identityAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Center(child: Text('${l10n.onboardingGatewayErrorIdentity} $err')),
          data: (identity) {
            if (identity == null) {
              return Center(
                child: Text(l10n.onboardingGatewayErrorNoIdentity),
              );
            }
            final appRole = identity.role == DeviceRole.gateway
                ? AppRole.gateway
                : AppRole.client;
            final permissionsGrantedAsync = ref.watch(
              allPermissionsGrantedProvider(appRole),
            );

            return permissionsGrantedAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) =>
                  Center(child: Text('${l10n.onboardingGatewayErrorPermissionsError} $err')),
              data: (permissionsGranted) {
                final hotspotStatus = ref.watch(gatewayIpProvider).valueOrNull;
                final canContinue =
                    permissionsGranted &&
                    (hotspotStatus is NetworkInfoResolved);
                return Column(
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
                        Icons.router,
                        color: theme.colorScheme.primary,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      l10n.onboardingGatewaySetupTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.onboardingGatewaySetupSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Card(
                      elevation: 0,
                      color: theme.colorScheme.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            GatewaySetupPermissionsItem(
                              permissionsGranted: permissionsGranted,
                            ),
                            Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: theme.colorScheme.outlineVariant
                                  .withValues(alpha: 0.3),
                            ),
                            GatewaySetupDeviceItem(
                              isExpanded: isIdentityExpanded,
                              identity: identity,
                              onTap: _toggleIdentityExpanded,
                            ),
                            Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: theme.colorScheme.outlineVariant
                                  .withValues(alpha: 0.3),
                            ),
                            const GatewaySetupHotspotItem(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: (_isLoading || _step == GatewaySetupStep.error)
                          ? Padding(
                              key: ValueKey(_statusMessage),
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: _step == GatewaySetupStep.error
                                      ? theme.colorScheme.errorContainer
                                            .withValues(alpha: 0.5)
                                      : theme.colorScheme.primaryContainer
                                            .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (_isLoading)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    Flexible(
                                      child: Text(
                                        _statusMessage,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color:
                                                  _step ==
                                                      GatewaySetupStep.error
                                                  ? theme.colorScheme.error
                                                  : theme.colorScheme.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: canContinue && !_isLoading
                            ? () => _onFinishSetup(permissionsGranted)
                            : null,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: theme.colorScheme.onPrimary,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(l10n.onboardingGatewaySetupBtnActivate),
                                  const SizedBox(width: 8),
                                  const Icon(CupertinoIcons.bolt_fill, size: 16),
                                ],
                              ),
                      ),
                    ),
                    if (_step == GatewaySetupStep.error)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextButton.icon(
                          onPressed: () => _onFinishSetup(permissionsGranted),
                          icon: const Icon(Icons.refresh_rounded, size: 18),
                          label: Text(l10n.attemptAgain),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
