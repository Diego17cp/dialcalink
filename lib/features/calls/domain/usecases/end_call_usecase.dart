import 'package:dialcalink/core/database/drift/tables/call_logs_table.dart' show CallType;
import 'package:dialcalink/core/database/drift/tables/sync_events_table.dart' show SyncEntityType, SyncEventType;
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/calls/domain/entities/call_log_entity.dart';
import 'package:dialcalink/features/calls/domain/repositories/call_repository.dart';
import 'package:dialcalink/features/calls/domain/services/active_call_resolver.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';
import 'package:dialcalink/features/sync/domain/repositories/sync_repository.dart';
import 'package:uuid/uuid.dart';

// Gateway excl.

class EndCallUseCase {
  EndCallUseCase(
    this._callRepository, 
    this._syncRepository,
    this._activeCallResolver
  );

  final CallRepository _callRepository;
  final SyncRepository _syncRepository;
  final ActiveCallResolver _activeCallResolver;
  final Uuid _uuid = const Uuid();

  Future<Result<CallLogEntity>> call({
    required DateTime endedAt,
    required String phoneNumber,
    required String sourceDeviceId,
  }) async {
    final lookupResult = await _activeCallResolver.resolveIdFor(phoneNumber);
    if (lookupResult.isFailure) {
      return Result.failure(lookupResult.failureOrNull!);
    }
    final lookup = lookupResult.valueOrNull!;
    final existing = lookup.existing;
    final callLog = CallLogEntity(
      id: lookup.id,
      phoneNumber: phoneNumber,
      callType: existing?.callType ?? CallType.incoming,
      sourceDeviceId: existing?.sourceDeviceId ?? sourceDeviceId,
      contactName: existing?.contactName,
      startedAt: existing?.startedAt,
      endedAt: endedAt,
    );
    
    final upsertResult = await _callRepository.upsertCall(callLog);
    if (upsertResult.isFailure) {
      return Result.failure(upsertResult.failureOrNull!);
    }
    final event = SyncEventEntity(
      id: _uuid.v4(),
      entityType: SyncEntityType.callLog,
      entityId: callLog.id,
      eventType: lookup.isExisting ? SyncEventType.updated : SyncEventType.created,
      createdAt: endedAt,
      synced: false,
    );
    final enqueueResult = await _syncRepository.enqueueEvent(event);
    if (enqueueResult.isFailure) {
      return Result.failure(enqueueResult.failureOrNull!);
    }
    return Result.ok(callLog);
  }
}