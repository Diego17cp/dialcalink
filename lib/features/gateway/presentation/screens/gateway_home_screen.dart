import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/app/layouts/glass_scaffold.dart';
import 'package:dialcalink/features/gateway/presentation/providers/gateway_home_provider.dart';
import 'package:dialcalink/features/gateway/presentation/widgets/gateway_home_device_info_card.dart';
import 'package:dialcalink/features/gateway/presentation/widgets/gateway_home_header_status.dart';
import 'package:dialcalink/features/gateway/presentation/widgets/gateway_home_scan_card.dart';
import 'package:dialcalink/features/gateway/presentation/widgets/gateway_home_stat_card.dart';
import 'package:dialcalink/shared/theme_toggler_button.dart';

class GatewayHomeScreen extends ConsumerWidget {
  const GatewayHomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesCountAsync = ref.watch(messagesTodayCountProvider);
    final callsCountAsync = ref.watch(callsTodayCountProvider);
    return GlassScaffold(
      title: 'DialcaLink Gateway',
      actions: const [ThemeTogglerButton()],
      body: Column(
        children: [
          const GatewayHomeHeaderStatus(),
          const SizedBox(height: 24),
          const GatewayHomeScanCard(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GatewayHomeStatCard(
                  type: GatewayHomeStatCardType.messages,
                  count: messagesCountAsync.valueOrNull ?? 0,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GatewayHomeStatCard(
                  type: GatewayHomeStatCardType.calls,
                  count: callsCountAsync.valueOrNull ?? 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const GatewayHomeDeviceInfoCard(),
        ],
      ),
    );
  }
}
