import 'package:notidialca/core/database/drift/tables/call_logs_table.dart' show CallType;
import 'package:notidialca/core/database/drift/tables/sync_events_table.dart' show SyncEntityType, SyncEventType;
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/calls/domain/entities/call_log_entity.dart';
import 'package:notidialca/features/calls/domain/repositories/call_repository.dart';
import 'package:notidialca/features/calls/domain/services/active_call_resolver.dart';
import 'package:notidialca/features/sync/domain/entities/sync_event_entity.dart';
import 'package:notidialca/features/sync/domain/repositories/sync_repository.dart';
import 'package:uuid/uuid.dart';

// Gateway excl.

class RegisterIncomingCallUseCase {
  RegisterIncomingCallUseCase(
    this._callRepository, 
    this._syncRepository,
    this._activeCallResolver
  );

  final CallRepository _callRepository;
  final SyncRepository _syncRepository;
  final ActiveCallResolver _activeCallResolver;
  final Uuid _uuid = const Uuid();

  Future<Result<CallLogEntity>> call({
    required String phoneNumber,
    required CallType callType,
    required String sourceDeviceId,
    String? contactName,
    DateTime? startedAt,
  }) async {
    final lookupResult = await _activeCallResolver.resolveIdFor(phoneNumber);
    if (lookupResult.isFailure) {
      return Result.failure(lookupResult.failureOrNull!);
    }
    final lookup = lookupResult.valueOrNull!;
    
    final callLog = CallLogEntity(
      id: lookup.id,
      phoneNumber: phoneNumber,
      callType: callType,
      sourceDeviceId: sourceDeviceId,
      contactName: contactName ?? lookup.existing?.contactName,
      startedAt: startedAt ?? DateTime.now(),
      endedAt: lookup.existing?.endedAt,
    );
    final saveResult = await _callRepository.upsertCall(callLog);
    if (saveResult.isFailure) {
      return Result.failure(saveResult.failureOrNull!);
    }
    final event = SyncEventEntity(
      id: _uuid.v4(),
      entityType: SyncEntityType.callLog,
      entityId: callLog.id,
      eventType: lookup.isExisting ? SyncEventType.updated : SyncEventType.created,
      createdAt: callLog.startedAt!,
      synced: false,
    );
    final enqueueResult = await _syncRepository.enqueueEvent(event);
    if (enqueueResult.isFailure) {
      return Result.failure(enqueueResult.failureOrNull!);
    }
    return Result.ok(callLog);
  }
}