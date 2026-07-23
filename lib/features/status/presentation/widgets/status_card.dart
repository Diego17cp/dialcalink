import 'package:dialcalink/core/platform/client/native/client_ui_bridge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final ClientConnectionStateBridge connectionState;
  const StatusCard({super.key, required this.connectionState});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (statusLabel, statusColor, statusIcon) = switch (connectionState) {
      ClientConnectionStateBridge.ready => (
        'Conectado',
        Colors.green,
        CupertinoIcons.wifi,
      ),
      ClientConnectionStateBridge.connecting => (
        'Conectando...',
        Colors.orange,
        CupertinoIcons.wifi,
      ),
      ClientConnectionStateBridge.reconnecting => (
        'Reconectando...',
        Colors.orange,
        CupertinoIcons.wifi,
      ),
      ClientConnectionStateBridge.handshakeRejected => (
        'Vínculo perdido',
        Colors.red,
        CupertinoIcons.wifi_exclamationmark,
      ),
      ClientConnectionStateBridge.disconnected => (
        'Desconectado',
        Colors.grey,
        CupertinoIcons.wifi_slash,
      ),
      ClientConnectionStateBridge.connected => (
        'Autenticando...',
        Colors.orange,
        CupertinoIcons.wifi,
      ),
      ClientConnectionStateBridge.error => (
        'Error de conexión',
        Colors.red,
        CupertinoIcons.exclamationmark_circle,
      ),
    };
    return Card(
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
                    'Estado del Servicio del Gateway',
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
    );
  }
}
