import 'package:dialcalink/core/database/drift/app_database_provider.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/core/notifications/providers/notification_service_provider.dart';
import 'package:dialcalink/core/platform/client/providers/client_ui_bridge_provider.dart';
import 'package:dialcalink/features/calls/presentation/providers/call_providers.dart';
import 'package:dialcalink/features/client/domain/client_connection_service.dart';
import 'package:dialcalink/features/sms/presentation/providers/sms_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_connection_service_provider.g.dart';

@riverpod
Future<ClientConnectionService> clientConnectionService(Ref ref) async {
  final identityService = await ref.watch(deviceIdentityServiceProvider.future);

  return ClientConnectionService(
    database: ref.watch(appDatabaseProvider),
    identityService: identityService,
    applySmsUseCase: ref.watch(applySyncedSmsUseCaseProvider),
    applyCallUseCase: ref.watch(applySyncedCallUseCaseProvider),
    notificationService: ref.watch(notificationServiceProvider),
    uiBridge: ref.watch(clientUiBridgeProvider),
  );
}
