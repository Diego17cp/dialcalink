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
        'Permisos concedidos',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        permissionsGranted
            ? 'SMS, Llamadas y Estado de Red aprobados.'
            : 'Faltan autorizar permisos requeridos por el rol.',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
