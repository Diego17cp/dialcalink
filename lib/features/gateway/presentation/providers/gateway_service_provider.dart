import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/database/drift/app_database_provider.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/core/platform/contacts/providers/contact_resolver_provider.dart';
import 'package:dialcalink/core/platform/gateway/providers/gateway_native_bridge_provider.dart';
import 'package:dialcalink/core/platform/gateway/providers/gateway_ui_bridge_provider.dart';
import 'package:dialcalink/features/calls/presentation/providers/call_providers.dart';
import 'package:dialcalink/features/gateway/domain/gateway_service.dart';
import 'package:dialcalink/features/sms/presentation/providers/sms_providers.dart';
import 'package:dialcalink/features/sync/presentation/providers/sync_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_service_provider.g.dart';

@riverpod
Future<GatewayService> gatewayService(Ref ref) async {
  final identityService = await ref.watch(deviceIdentityServiceProvider.future);
  return GatewayService(
    nativeBridge: ref.watch(gatewayNativeBridgeProvider),
    uiBridge: ref.watch(gatewayUiBridgeProvider),
    database: ref.watch(appDatabaseProvider),
    identityService: identityService,
    contactResolverService: ref.watch(contactResolverServiceProvider),
    receiveSmsUseCase: ref.watch(receiveSmsUseCaseProvider),
    registerIncomingCallUseCase: ref.watch(registerIncomingCallUseCaseProvider),
    endCallUseCase: ref.watch(endCallUseCaseProvider),
    getPendingSyncEventsUseCase: ref.watch(getPendingSyncEventsUseCaseProvider),
    smsRepository: ref.watch(smsRepositoryProvider),
    callRepository: ref.watch(callRepositoryProvider),
    syncRepository: ref.watch(syncRepositoryProvider),
  );
}