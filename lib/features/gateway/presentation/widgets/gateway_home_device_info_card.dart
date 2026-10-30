import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:dialcalink/core/network/discovery/gateway_ip_refresher_provider.dart';
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
    final l10n = context.l10n;
    ref.watch(gatewayIpRefresherProvider);
    final localDeviceIdentity = ref.watch(localDeviceIdentityProvider).value;
    final localDeviceIp = ref.watch(gatewayIpProvider).value;
    final homeState = ref.watch(gatewayHomeNotifierProvider);
    final uptime = ref.watch(gatewayUptimeProvider).valueOrNull;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.gatewayDeviceInfo,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (localDeviceIdentity != null) ...[
            GatewayHomeDeviceInfoItem(
              title: l10n.gatewayDeviceInfoName,
              value: localDeviceIdentity.name,
              icon: CupertinoIcons.device_phone_portrait,
            ),
            if (localDeviceIp != null &&
                localDeviceIp is NetworkInfoResolved) ...[
              GatewayHomeDeviceInfoItem(
                title: l10n.gatewayDeviceInfoIP,
                value: localDeviceIp.ip,
                icon: Icons.router,
              ),
            ] else ...[
              GatewayHomeDeviceInfoItem(
                title: l10n.gatewayDeviceInfoIP,
                value: l10n.gatewayDeviceInfoNotIP,
                icon: CupertinoIcons.wifi_slash,
              ),
            ],
            GatewayHomeDeviceInfoItem(
              title: l10n.gatewayDeviceInfoStartedFrom,
              value: homeState.serviceStartedAt != null
                  ? formatDateTime(homeState.serviceStartedAt)
                  : l10n.gatewayDeviceInfoNotStarted,
              icon: CupertinoIcons.clock,
            ),
            GatewayHomeDeviceInfoItem(
              title: l10n.gatewayDeviceInfoActivityTime,
              value: formatDuration(uptime),
              icon: CupertinoIcons.hourglass,
            ),
          ],
        ],
      ),
    );
  }
}
