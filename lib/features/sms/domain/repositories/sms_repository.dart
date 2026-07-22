import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/sms/domain/entities/sms_message_entity.dart';

abstract class SmsRepository {
  Stream<List<SmsMessageEntity>> watchAllMessages();
  Stream<List<SmsMessageEntity>> watchMessagesByPhoneNumber(String phoneNumber);
  Stream<int> watchUnreadCount();
  Future<Result<void>> insertMessage(SmsMessageEntity message);
  Future<Result<void>> upsertMessage(SmsMessageEntity message);
  Future<Result<void>> markAsRead(String messageId);
  Future<Result<void>> markAllAsReadByPhoneNumber(String phoneNumber);
  Future<Result<SmsMessageEntity>> findById(String id);
  Future<int> countByDateAndId(DateTime date, String id);
  Stream<int> watchCountByDateAndId(DateTime date, String id);
  Future<Result<void>> deleteMessagesByPhoneNumber(String phoneNumber);
}