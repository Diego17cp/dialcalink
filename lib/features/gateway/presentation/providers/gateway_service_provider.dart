import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notidialca/core/database/drift/app_database_provider.dart';
import 'package:notidialca/core/identity/providers/device_identity_provider.dart';
import 'package:notidialca/core/platform/gateway/providers/gateway_native_bridge_provider.dart';
import 'package:notidialca/features/calls/presentation/providers/call_providers.dart';
import 'package:notidialca/features/gateway/domain/gateway_service.dart';
import 'package:notidialca/features/sms/presentation/providers/sms_providers.dart';
import 'package:notidialca/features/sync/presentation/providers/sync_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_service_provider.g.dart';

@riverpod
Future<GatewayService> gatewayService(Ref ref) async {
  final identityService = await ref.watch(deviceIdentityServiceProvider.future);
  return GatewayService(
    nativeBridge: ref.watch(gatewayNativeBridgeProvider),
    database: ref.watch(appDatabaseProvider),
    identityService: identityService,
    receiveSmsUseCase: ref.watch(receiveSmsUseCaseProvider),
    registerIncomingCallUseCase: ref.watch(registerIncomingCallUseCaseProvider),
    endCallUseCase: ref.watch(endCallUseCaseProvider),
    getPendingSyncEventsUseCase: ref.watch(getPendingSyncEventsUseCaseProvider),
    smsRepository: ref.watch(smsRepositoryProvider),
    callRepository: ref.watch(callRepositoryProvider),
    syncRepository: ref.watch(syncRepositoryProvider),
  );
}