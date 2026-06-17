import 'package:notidialca/core/database/drift/daos/calls_dao.dart';
import 'package:notidialca/core/failures/failure.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/calls/data/mappers/call_log_mapper.dart';
import 'package:notidialca/features/calls/domain/entities/call_log_entity.dart';
import 'package:notidialca/features/calls/domain/repositories/call_repository.dart';

class CallRepositoryImpl implements CallRepository {
  CallRepositoryImpl(this._dao);
  final CallsDao _dao;

  @override
  Stream<List<CallLogEntity>> watchAllCalls() => _dao
      .watchAllCalls()
      .map((rows) => rows.map(CallLogMapper.toEntity).toList());

  @override
  Stream<List<CallLogEntity>> watchCallsByPhoneNumber(String phoneNumber) => _dao
      .watchCallsByPhoneNumber(phoneNumber)
      .map((rows) => rows.map(CallLogMapper.toEntity).toList());

  @override
  Future<Result<void>> insertCall(CallLogEntity callLog) async {
    try {
      await _dao.insertCall(CallLogMapper.toCompanion(callLog));
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        IntegrityFailure('Error insertando llamada ${callLog.id}', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> upsertCall(CallLogEntity callLog) async {
    try {
      await _dao.upsertCall(CallLogMapper.toCompanion(callLog));
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        IntegrityFailure('Error sincronizando llamada ${callLog.id}', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> markCallEnded(String callId, DateTime endedAt) async {
    try {
      await _dao.markCallEnded(callId, endedAt);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error marcando llamada $callId como finalizada', cause: e),
      );
    }
  }

  @override
  Future<Result<CallLogEntity>> findById(String id) async {
    try {
      final row = await _dao.findById(id);
      if (row == null) {
        return Result.failure(
          NotFoundFailure('No existe una llamada con id $id'),
        );
      }
      return Result.ok(CallLogMapper.toEntity(row));
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error buscando llamada $id', cause: e),
      );
    }
  }

  @override
  Future<Result<CallLogEntity?>> findOpenCallByPhoneNumber(String phoneNumber) async {
    try {
      final row = await _dao.findOpenCallByPhoneNumber(phoneNumber);
      return Result.ok(row == null ? null : CallLogMapper.toEntity(row));
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error buscando llamada abierta para el número $phoneNumber', cause: e),
      );
    }
  }
}