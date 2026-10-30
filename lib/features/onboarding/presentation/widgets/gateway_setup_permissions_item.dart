import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/material.dart';

class GatewaySetupPermissionsItem extends StatelessWidget {
  final bool permissionsGranted;
  const GatewaySetupPermissionsItem({
    super.key,
    required this.permissionsGranted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: permissionsGranted
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.orange.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          permissionsGranted
              ? Icons.check_circle_rounded
              : Icons.warning_rounded,
          color: permissionsGranted
              ? Colors.green.shade600
              : Colors.orange.shade600,
          size: 28,
        ),
      ),
      title: Text(
        l10n.onboardingGatewaySetupPermissionsGranted,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        permissionsGranted
            ? l10n.onboardingGatewaySetupPermissionsGrantedSubtitle
            : l10n.onboardingGatewaySetupPermissionsNotGrantedSubtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
