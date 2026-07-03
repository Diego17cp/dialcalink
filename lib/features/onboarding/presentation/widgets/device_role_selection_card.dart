import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dialcalink/core/database/drift/tables/devices_table.dart';

class DeviceRoleSelectionCard extends StatelessWidget {
  final DeviceRole role;
  final DeviceRole selectedRole;
  final ValueChanged<DeviceRole> onSelected;

  const DeviceRoleSelectionCard({
    super.key,
    required this.role,
    required this.selectedRole,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = selectedRole == role;

    final config = {
      DeviceRole.client: {
        'title': 'Dispositivo Principal',
        'subtitle': 'Recibe SMS y notificaciones de llamadas desde otro teléfono.',
        'badge': 'Cliente',
        'badgeColor': theme.colorScheme.primary,
        'icon': CupertinoIcons.device_phone_portrait,
        'iconColor': theme.colorScheme.primary,
        'iconBg': theme.colorScheme.primary.withValues(alpha: 0.1),
      },
      DeviceRole.gateway: {
        'title': 'Dispositivo con SIM',
        'subtitle': 'Comparte SMS y llamadas con tu dispositivo principal.',
        'badge': 'Gateway',
        'badgeColor': theme.colorScheme.secondary,
        'icon': Icons.sim_card,
        'iconColor': theme.colorScheme.secondary,
        'iconBg': theme.colorScheme.secondary.withValues(alpha: 0.1),
      }
    }[role]!;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
          width: isSelected ? 2 : 1,
        )
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => onSelected(role),
        child: Stack(
          children: [
            Positioned(
              top: 12,
              left: 12,
              child: Radio<DeviceRole>(
                value: role,
                groupValue: selectedRole,
                activeColor: theme.colorScheme.primary,
                onChanged: (DeviceRole? value) {
                  if (value != null) onSelected(value);
                }
              )
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: config['badgeColor'] as Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  config['badge'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 24, left: 24, right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: config['iconBg'] as Color,
                    child: Icon(
                      config['icon'] as IconData,
                      color: config['iconColor'] as Color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    config['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    config['subtitle'] as String,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  )
                ]
              )
                
            )
          ]
        )
      )
    );
  }
}