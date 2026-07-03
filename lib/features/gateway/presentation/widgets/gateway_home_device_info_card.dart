import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/core/network/discovery/local_network_info_provider.dart';
import 'package:dialcalink/core/network/discovery/network_info_result.dart';
import 'package:dialcalink/features/gateway/presentation/providers/gateway_home_provider.dart';
import 'package:dialcalink/features/gateway/presentation/utils/formatters.dart';
import 'package:dialcalink/features/gateway/presentation/widgets/gateway_home_device_info_item.dart';

class GatewayHomeDeviceInfoCard extends ConsumerWidget {
  const GatewayHomeDeviceInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localDeviceIdentity = ref.watch(localDeviceIdentityProvider).value;
    final localDeviceIp = ref.watch(gatewayIpProvider).value;
    final homeState = ref.watch(gatewayHomeNotifierProvider);
    final uptime = ref.watch(gatewayUptimeProvider).valueOrNull;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información del Dispositivo',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (localDeviceIdentity != null) ...[
            GatewayHomeDeviceInfoItem(
              title: 'Nombre del Dispositivo',
              value: localDeviceIdentity.name,
              icon: CupertinoIcons.device_phone_portrait,
            ),
            if (localDeviceIp != null &&
                localDeviceIp is NetworkInfoResolved) ...[
              GatewayHomeDeviceInfoItem(
                title: 'IP del Dispositivo',
                value: localDeviceIp.ip,
                icon: Icons.router,
              ),
            ] else ...[
              const GatewayHomeDeviceInfoItem(
                title: 'IP del Dispositivo',
                value: 'No disponible',
                icon: CupertinoIcons.wifi_slash,
              ),
            ],
            GatewayHomeDeviceInfoItem(
              title: 'Activo desde',
              value: homeState.serviceStartedAt != null
                  ? formatDateTime(homeState.serviceStartedAt)
                  : 'No Iniciado',
              icon: CupertinoIcons.clock,
            ),
            GatewayHomeDeviceInfoItem(
              title: 'Tiempo de actividad',
              value: formatDuration(uptime),
              icon: CupertinoIcons.hourglass,
            ),
          ],
        ],
      ),
    );
  }
}
