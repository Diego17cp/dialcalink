import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/database/drift/app_database_provider.dart';
import 'package:dialcalink/features/sync/presentation/providers/sync_providers.dart';
import 'package:dialcalink/features/calls/data/repositories/call_repository_impl.dart';
import 'package:dialcalink/features/calls/domain/entities/call_log_entity.dart';
import 'package:dialcalink/features/calls/domain/repositories/call_repository.dart';
import 'package:dialcalink/features/calls/domain/services/active_call_resolver.dart';
import 'package:dialcalink/features/calls/domain/usecases/apply_synced_call_usecase.dart';
import 'package:dialcalink/features/calls/domain/usecases/end_call_usecase.dart';
import 'package:dialcalink/features/calls/domain/usecases/register_incoming_call_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_providers.g.dart';

@riverpod
CallRepository callRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return CallRepositoryImpl(db.callsDao);
}

@riverpod
ActiveCallResolver activeCallResolver(Ref ref) {
  return ActiveCallResolver(ref.watch(callRepositoryProvider));
}

// Gateway
@riverpod
RegisterIncomingCallUseCase registerIncomingCallUseCase(Ref ref) {
  return RegisterIncomingCallUseCase(
    ref.watch(callRepositoryProvider),
    ref.watch(syncRepositoryProvider),
    ref.watch(activeCallResolverProvider),
  );
}

// Gateway
@riverpod
EndCallUseCase endCallUseCase(Ref ref) {
  return EndCallUseCase(
    ref.watch(callRepositoryProvider),
    ref.watch(syncRepositoryProvider),
    ref.watch(activeCallResolverProvider),
  );
}

// Client
@riverpod
ApplySyncedCallUseCase applySyncedCallUseCase(Ref ref) {
  return ApplySyncedCallUseCase(ref.watch(callRepositoryProvider));
}

@riverpod
Stream<List<CallLogEntity>> allCalls(Ref ref) {
  final repo = ref.watch(callRepositoryProvider);
  return repo.watchAllCalls();
}

@riverpod
Stream<List<CallLogEntity>> callsByPhoneNumber(Ref ref, String phoneNumber) {
  final repo = ref.watch(callRepositoryProvider);
  return repo.watchCallsByPhoneNumber(phoneNumber);
}
