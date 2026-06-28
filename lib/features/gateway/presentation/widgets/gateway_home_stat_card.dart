import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum GatewayHomeStatCardType {
  messages,
  calls,
}

class GatewayHomeStatCard extends StatelessWidget {
  final GatewayHomeStatCardType type;
  final int count;

  const GatewayHomeStatCard({
    super.key,
    required this.type,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = type == GatewayHomeStatCardType.messages ? 'Mensajes' : 'Llamadas';
    final icon = type == GatewayHomeStatCardType.messages ? CupertinoIcons.chat_bubble_2 : CupertinoIcons.phone;
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: theme.colorScheme.outline,
          width: 1,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1),
              child: Icon(
                icon,
                size: 40,
                color: theme.colorScheme.secondary,
              )
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              )
            ),
            const SizedBox(height: 8),
            Text(
              '$count hoy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurfaceVariant,
              )
            ),
          ],
        )
      )
    );
  }
}