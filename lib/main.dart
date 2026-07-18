// export 'package:dialcalink/gateway_entrypoint/main_gateway_service.dart' show gatewayServiceEntrypoint;
import 'package:dialcalink/features/client/presentation/providers/client_connection_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/app/app.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/features/gateway/presentation/providers/gateway_service_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);
  final container = ProviderContainer();
  final identityService = await container.read(deviceIdentityServiceProvider.future);
  await identityService.ensureBootstrapped();
  runApp(const ProviderScope(child: App()));
}

@pragma('vm:entry-point')
void gatewayServiceEntrypoint() {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  container.read(gatewayServiceProvider.future).then(
    (gatewayService) {
      gatewayService.start().catchError((Object error, StackTrace stack) {
      });
    },
    onError: (Object error, StackTrace stack) {
    },
  );
}

@pragma('vm:entry-point')
void clientServiceEntrypoint() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[DIALCA][CLIENT-ENTRYPOINT] Iniciando entrypoint del Cliente');

  final container = ProviderContainer();
  container.read(clientConnectionServiceProvider.future).then(
    (service) {
      debugPrint('[DIALCA][CLIENT-ENTRYPOINT] ClientConnectionService construido');
      service.start().then((_) {
        debugPrint('[DIALCA][CLIENT-ENTRYPOINT] start() completado');
      }).catchError((Object e, StackTrace s) {
        debugPrint('[DIALCA][CLIENT-ENTRYPOINT] Error en start(): $e');
      });
    },
    onError: (Object e, StackTrace s) {
      debugPrint('[DIALCA][CLIENT-ENTRYPOINT] Error construyendo servicio: $e');
    },
  );
}