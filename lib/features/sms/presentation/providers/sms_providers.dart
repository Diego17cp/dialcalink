import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notidialca/core/database/drift/app_database_provider.dart';
import 'package:notidialca/features/sync/presentation/providers/sync_providers.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/features/sms/data/repositories/sms_repository_impl.dart';
import 'package:notidialca/features/sms/domain/entities/sms_message_entity.dart';
import 'package:notidialca/features/sms/domain/repositories/sms_repository.dart';
import 'package:notidialca/features/sms/domain/usecases/apply_synced_sms_usecase.dart';
import 'package:notidialca/features/sms/domain/usecases/receive_sms_usecase.dart';
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