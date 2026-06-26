import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notidialca/core/network/discovery/local_network_info_provider.dart';
import 'package:notidialca/core/network/discovery/network_info_result.dart';

class GatewaySetupHotspotItem extends ConsumerWidget {
  const GatewaySetupHotspotItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hotspotAsync = ref.watch(gatewayIpProvider);

    return hotspotAsync.when(
      loading: () => const ListTile(
        leading: CircularProgressIndicator(),
        title: Text('Verificando Hotspot...'),
      ),
      error: (err, _) => ListTile(
        leading: const Icon(Icons.error, color: Colors.red),
        title: Text('Error: $err'),
      ),
      data: (result) {
        final isActive = result is NetworkInfoResolved;
        final String subtitle;
        
        if (result is NetworkInfoResolved) {
          subtitle = 'Punto de acceso activo en: ${result.ip}';
        } else if (result is NetworkInfoNotConnected) {
          subtitle = 'Hotspot desactivado. Por favor, actívelo.';
        } else if (result is NetworkInfoPermissionDenied) {
          subtitle = 'Faltan permisos de ubicación para detectar la red.';
        } else {
          subtitle = 'No se pudo detectar el Hotspot.';
        }

        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isActive 
                  ? Colors.green.withValues(alpha: 0.1) 
                  : Colors.orange.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive ? Icons.wifi_tethering_rounded : Icons.wifi_tethering_off_rounded,
              color: isActive ? Colors.green.shade600 : Colors.orange.shade600,
              size: 28,
            ),
          ),
          title: Text(
            'Hotspot (Punto de Acceso)',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isActive ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.error,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(gatewayIpProvider),
            tooltip: 'Reintentar',
          ),
        );
      },
    );
  }
}