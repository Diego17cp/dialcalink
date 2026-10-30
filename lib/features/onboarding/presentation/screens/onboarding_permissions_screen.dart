import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dialcalink/app/layouts/glass_scaffold.dart';
import 'package:dialcalink/core/database/drift/tables/devices_table.dart';
import 'package:dialcalink/core/permissions/app_permission.dart';
import 'package:dialcalink/core/permissions/providers/permissions_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingPermissionsScreen extends ConsumerStatefulWidget {
  final DeviceRole role;
  const OnboardingPermissionsScreen({super.key, required this.role});
  @override
  ConsumerState<OnboardingPermissionsScreen> createState() =>
      _OnboardingPermissionsScreenState();
}

class _OnboardingPermissionsScreenState
    extends ConsumerState<OnboardingPermissionsScreen> {
  Map<AppPermission, PermissionStatus> _statuses = {};
  bool _loading = false;
  bool get _canContinue => _statuses.values.every((status) => status.isGranted);
  void _onContinue() {
    if (widget.role == DeviceRole.gateway) {
      context.push('/onboarding/gateway-setup');
    } else {
      context.push('/onboarding/pairing-scan');
    }
  }

  bool get _hasPermanentlyDenied =>
      _statuses.values.any((status) => status.isPermanentlyDenied);
  @override
  void initState() {
    super.initState();
    _loadCurrentStatuses();
  }

  Future<void> _loadCurrentStatuses() async {
    final service = ref.read(permissionsServiceProvider);
    final appRole = widget.role == DeviceRole.gateway
        ? AppRole.gateway
        : AppRole.client;
    final statuses = await service.statusForRole(appRole);
    setState(() => _statuses = statuses);
  }

  Future<void> _requestAll() async {
    setState(() => _loading = true);
    final service = ref.read(permissionsServiceProvider);
    final appRole = widget.role == DeviceRole.gateway
        ? AppRole.gateway
        : AppRole.client;
    final updated = await service.requestForRole(appRole);
    setState(() {
      _statuses = updated;
      _loading = false;
    });
  }

  Future<void> _openSettings() async {
    final service = ref.read(permissionsServiceProvider);
    await service.openSettings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return GlassScaffold(
      onBackTap: () => context.pop(),
      title: l10n.permissions,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              CupertinoIcons.padlock_solid,
              color: theme.colorScheme.primary,
              size: 50,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            l10n.onboardingPermissionsTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.onboardingPermissionsSubtitle,
            style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ..._statuses.entries.map((entry) {
            final permission = entry.key;
            final status = entry.value;

            final IconData statusIcon;
            final Color statusColor;

            if (status.isGranted) {
              statusIcon = Icons.check_circle_rounded;
              statusColor = Colors.green.shade600;
            } else if (status.isPermanentlyDenied) {
              statusIcon = Icons.error_rounded;
              statusColor = theme.colorScheme.error;
            } else {
              statusIcon = Icons.pending_rounded;
              statusColor = Colors.orange.shade600;
            }
            return Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant.withAlpha(128),
                  width: 1,
                ),
              ),
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      permission.icon,
                      color: theme.colorScheme.tertiary,
                      size: 25,
                    ),
                  ),
                  title: Text(
                    permission.getTitle(context),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      permission.getDescription(context),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.2,
                      ),
                    ),
                  ),
                  trailing: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(32),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(statusIcon, color: statusColor, size: 22),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 32),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_canContinue)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _onContinue,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.continueLbl),
                        const SizedBox(width: 8),
                        const Icon(CupertinoIcons.arrowtriangle_right_fill, size: 16),
                      ],
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _loading ? null : _requestAll,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(l10n.requestPermissions),
                              const SizedBox(width: 8),
                              const Icon(
                                CupertinoIcons.arrowtriangle_right_fill,
                                size: 16,
                              ),
                            ],
                          ),
                  ),
                ),
              if (_hasPermanentlyDenied) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _openSettings,
                  child: Text(l10n.onboardingPermissionsManualGrant),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
