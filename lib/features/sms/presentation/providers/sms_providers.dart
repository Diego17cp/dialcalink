import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/database/drift/app_database_provider.dart';
import 'package:dialcalink/features/sync/presentation/providers/sync_providers.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/features/sms/data/repositories/sms_repository_impl.dart';
import 'package:dialcalink/features/sms/domain/entities/sms_message_entity.dart';
import 'package:dialcalink/features/sms/domain/repositories/sms_repository.dart';
import 'package:dialcalink/features/sms/domain/usecases/apply_synced_sms_usecase.dart';
import 'package:dialcalink/features/sms/domain/usecases/receive_sms_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sms_providers.g.dart';

@riverpod
SmsRepository smsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SmsRepositoryImpl(db.smsDao);
}

// Gateway
@riverpod
ReceiveSmsUseCase receiveSmsUseCase(Ref ref) {
  return ReceiveSmsUseCase(
    ref.watch(smsRepositoryProvider),
    ref.watch(syncRepositoryProvider),
  );
}

// Client
@riverpod
ApplySyncedSmsUseCase applySyncedSmsUseCase(Ref ref) {
  return ApplySyncedSmsUseCase(ref.watch(smsRepositoryProvider));
}

@riverpod
Stream<List<SmsMessageEntity>> allSmsMessages(Ref ref) {
  final repo = ref.watch(smsRepositoryProvider);
  return repo.watchAllMessages();
}

@riverpod
Stream<List<SmsMessageEntity>> smsMessagesByPhoneNumber(
  Ref ref,
  String phoneNumber,
) {
  final repo = ref.watch(smsRepositoryProvider);
  return repo.watchMessagesByPhoneNumber(phoneNumber);
}

@riverpod
Stream<int> unreadSmsCount(Ref ref) {
  final repo = ref.watch(smsRepositoryProvider);
  return repo.watchUnreadCount();
}

@riverpod
Future<Result<void>> markSmsAsRead(Ref ref, String messageId) {
  final repo = ref.watch(smsRepositoryProvider);
  return repo.markAsRead(messageId);
}

@riverpod
Future<Result<void>> markConversationAsRead(Ref ref, String phoneNumber) {
  final repo = ref.watch(smsRepositoryProvider);
  return repo.markAllAsReadByPhoneNumber(phoneNumber);
}

@riverpod
Stream<List<SmsMessageEntity>> smsConversations(Ref ref) {
  return ref.watch(smsRepositoryProvider).watchAllMessages().map((messages) {
    final Map<String, SmsMessageEntity> groups = {};
    for (final msg in messages) {
      if (!groups.containsKey(msg.phoneNumber)) {
        groups[msg.phoneNumber] = msg;
      }
    }
    return groups.values.toList();
  });
}