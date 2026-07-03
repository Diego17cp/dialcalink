import 'package:notidialca/core/database/drift/daos/sms_dao.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/core/failures/failure.dart';
import 'package:notidialca/features/sms/data/mappers/sms_message_mapper.dart';
import 'package:notidialca/features/sms/domain/entities/sms_message_entity.dart';
import 'package:notidialca/features/sms/domain/repositories/sms_repository.dart';

class SmsRepositoryImpl implements SmsRepository {
  SmsRepositoryImpl(this._dao);
  final SmsDao _dao;

  @override
  Stream<List<SmsMessageEntity>> watchAllMessages() => _dao
    .watchAllMessages()
    .map((rows) => rows.map(SmsMessageMapper.toEntity).toList());

  @override
  Stream<List<SmsMessageEntity>> watchMessagesByPhoneNumber(String phoneNumber) => _dao
    .watchMessagesByPhoneNumber(phoneNumber)
    .map((rows) => rows.map(SmsMessageMapper.toEntity).toList());

  @override
  Stream<int> watchUnreadCount() => _dao.watchUnreadCount();

  @override
  Future<Result<void>> insertMessage(SmsMessageEntity entity) async {
    try {
      await _dao.insertMessage(SmsMessageMapper.toCompanion(entity));
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        IntegrityFailure('Error insertando mensaje ${entity.id}', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> upsertMessage(SmsMessageEntity entity) async {
    try {
      await _dao.upsertMessage(SmsMessageMapper.toCompanion(entity));
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        IntegrityFailure('Error sincronizando mensaje ${entity.id}', cause: e),
      );
    }
  }

  @override
  Future<Result<void>> markAsRead(String messageId) async {
    try {
      await _dao.markAsRead(messageId);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error marcando mensaje $messageId como leído', cause: e),
      );
    }
  }
  @override
  Future<Result<void>> markAllAsReadByPhoneNumber(String phoneNumber) async {
    try {
      await _dao.markAllAsReadByPhoneNumber(phoneNumber);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error marcando todos los mensajes de $phoneNumber como leídos', cause: e),
      );
    }
  }

  @override
  Future<Result<SmsMessageEntity>> findById(String id) async {
    try {
      final row = await _dao.findById(id);
      if (row == null) {
        return Result.failure(
          NotFoundFailure('No existe un mensaje con id $id'),
        );
      }
      return Result.ok(SmsMessageMapper.toEntity(row));
    } catch (e) {
      return Result.failure(
        DatabaseFailure('Error buscando mensaje $id', cause: e),
      );
    }
  }

  @override
  Future<int> countByDateAndId(DateTime date, String id) async {
    try {
      return await _dao.countByDateAndId(date, id);
    } catch (e) {
      throw DatabaseFailure('Error contando mensajes para fecha $date y id $id', cause: e);
    }
  }

  @override
  Stream<int> watchCountByDateAndId(DateTime date, String id) {
    try {
      return _dao.watchCountByDateAndId(date, id);
    } catch (e) {
      throw DatabaseFailure('Error observando conteo de mensajes para fecha $date y id $id', cause: e);
    }
  }
}