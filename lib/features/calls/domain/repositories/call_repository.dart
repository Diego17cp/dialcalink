import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/calls/domain/entities/call_log_entity.dart';

abstract class CallRepository {
  Stream<List<CallLogEntity>> watchAllCalls();
  Stream<List<CallLogEntity>> watchCallsByPhoneNumber(String phoneNumber);
  Future<Result<void>> insertCall(CallLogEntity callLog);
  Future<Result<void>> upsertCall(CallLogEntity callLog);
  Future<Result<void>> markCallEnded(String callId, DateTime endedAt);
  Future<Result<CallLogEntity>> findById(String id);
}