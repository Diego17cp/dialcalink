import 'package:dialcalink/core/platform/client/providers/client_native_bridge_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dialcalink/app/layouts/glass_scaffold.dart';
import 'package:dialcalink/app/layouts/widgets/bottom_nav.dart';
import 'package:dialcalink/app/router/tab_config.dart';
import 'package:dialcalink/features/devices/presentation/providers/device_providers.dart';
import 'package:dialcalink/shared/theme_toggler_button.dart';

class ClientShellScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const ClientShellScreen({super.key, required this.navigationShell});

  @override
  ConsumerState<ClientShellScreen> createState() => _ClientShellScreenState();
}

class _ClientShellScreenState extends ConsumerState<ClientShellScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureClientServiceRunning();
    });
  }
  Future<void> _ensureClientServiceRunning() async {
    final linked = ref.read(linkedDevicesProvider).valueOrNull;
    if (linked == null || linked.isEmpty) return;
    final bridge = ref.read(clientNativeBridgeProvider);
    final isRunning = await bridge.isClientServiceRunning();
    if (!isRunning) {
      try {
        await bridge.startClientService();
        debugPrint('[DIALCA] ClientForegroundService arrancado desde shell');
      } catch (e) {
        debugPrint('[DIALCA] Error al arrancar ClientForegroundService desde shell: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    ref.listen(linkedDevicesProvider, (prev, next) {
      final hadGateway = prev?.valueOrNull?.isNotEmpty ?? false;
      final hasGateway = next.valueOrNull?.isNotEmpty ?? false;
      if (!hadGateway && hasGateway) {
        _ensureClientServiceRunning();
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
