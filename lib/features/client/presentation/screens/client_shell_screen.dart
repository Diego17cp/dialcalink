import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notidialca/app/layouts/glass_scaffold.dart';
import 'package:notidialca/app/layouts/widgets/bottom_nav.dart';
import 'package:notidialca/app/router/tab_config.dart';
import 'package:notidialca/core/identity/providers/device_identity_provider.dart';
import 'package:notidialca/core/network/websocket/client/providers/gateway_ws_client_notifier.dart';
import 'package:notidialca/core/network/websocket/client/ws_connection_state.dart';
import 'package:notidialca/core/notifications/providers/notification_service_provider.dart';
import 'package:notidialca/features/devices/domain/entities/device_entity.dart';
import 'package:notidialca/features/devices/presentation/providers/device_providers.dart';
import 'package:notidialca/shared/theme_toggler_button.dart';

class ClientShellScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const ClientShellScreen({super.key, required this.navigationShell});

  @override
  ConsumerState<ClientShellScreen> createState() => _ClientShellScreenState();
}

class _ClientShellScreenState extends ConsumerState<ClientShellScreen> {
  bool _notificationsInitialized = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotifications();
    });
  }
  Future<void> _initializeNotifications() async {
    if (_notificationsInitialized) return;
    _notificationsInitialized = true;
    await ref.read(notificationServiceProvider).initialize(
      onNotificationTapped: (payload) {
        if (payload != null && mounted) {
          context.go('/client/sms/${Uri.encodeComponent(payload)}');
        }
      }
    );
  }
  void _connectToGateway(DeviceEntity gateway) {
    final identity = ref.read(localDeviceIdentityProvider).valueOrNull;
    if (identity == null) return;

    ref.read(gatewayWsClientNotifierProvider.notifier).connect(
      ip: gateway.lastKnownIp ?? '',
      port: gateway.lastKnownPort ?? 8888,
      clientDeviceId: identity.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(linkedDevicesProvider, (prev, next) {
      final gateway = next.valueOrNull?.firstOrNull;
      if (gateway == null) return;
      final currentStatus = ref.read(gatewayWsClientNotifierProvider);
      if (currentStatus is WsDisconnected || currentStatus is WsError) {
        _connectToGateway(gateway);
      }
    });
    final currentTab = clientTabs[widget.navigationShell.currentIndex];

    return GlassScaffold(
      title: currentTab.title,
      scrollable: false,
      bottomNavigationBar: BottomNav(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) => widget.navigationShell.goBranch(
          index,
          initialLocation: index == widget.navigationShell.currentIndex,
        ),
      ),
      actions: const [ThemeTogglerButton()],
      body: widget.navigationShell,
    );
  }
}
