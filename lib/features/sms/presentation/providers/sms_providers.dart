import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:dialcalink/core/platform/client/native/client_ui_bridge.dart';
import 'package:dialcalink/core/platform/client/providers/client_ui_bridge_provider.dart';
import 'package:dialcalink/core/platform/gateway/providers/gateway_control_bridge_provider.dart';
import 'package:dialcalink/features/sms/domain/usecases/send_sms_usecase.dart';
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
Future<Result<void>> Function(String to, String content) sendSmsNative(Ref ref) {
  final bridge = ref.watch(gatewayControlBridgeProvider);
  return bridge.sendSms;
}
@riverpod
SendSmsUseCase sendSmsUseCase(Ref ref) {
  return SendSmsUseCase(
    ref.watch(smsRepositoryProvider),
    ref.watch(syncRepositoryProvider),
    ref.watch(sendSmsNativeProvider),
  );
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
Stream<SmsSentResult> smsSentResultStream(Ref ref) {
  final bridge = ref.watch(clientUiBridgeProvider);
  return bridge.smsSentResults;
}

@riverpod
class SmsSentStatuses extends _$SmsSentStatuses {
  @override
  Map<String, SmsSentResult> build() {
    ref.listen(smsSentResultStreamProvider, (prev, next) {
      final result = next.valueOrNull;
      if (result != null) {
        state = {...state, result.id: result};
      }
    });
    return {};
  }
}

@riverpod
Stream<List<SmsMessageEntity>> smsConversations(Ref ref) {
  return ref.watch(smsRepositoryProvider).watchAllMessages().map((messages) {
    final Map<String, List<SmsMessageEntity>> grouped = {};
    for (final msg in messages) {
      grouped.putIfAbsent(msg.phoneNumber, () => []).add(msg);
    }
    return grouped.values.map((group) {
      final latest = group.first;
      final resolvedName = group
          .map((m) => m.contactName)
          .firstWhere((n) => n != null, orElse: () => null);
      return latest.contactName == resolvedName
          ? latest
          : latest.copyWith(contactName: resolvedName);
    }).toList();
  });
}

@riverpod
Stream<List<WsContactDto>> syncedContactsStream(Ref ref) {
  final bridge = ref.watch(clientUiBridgeProvider);
  return bridge.contacts;
}

@riverpod
class SmsContactSearchQuery extends _$SmsContactSearchQuery {
  @override
  String build() => '';
  void update(String query) => state = query;
}

@riverpod
List<WsContactDto> filteredContacts(Ref ref) {
  final contactsAsync = ref.watch(syncedContactsStreamProvider);
  final query = ref.watch(smsContactSearchQueryProvider).toLowerCase();

  final allContacts = contactsAsync.valueOrNull ?? [];

  if (query.isEmpty) return [];

  return allContacts.where((c) {
    return c.name.toLowerCase().contains(query) || c.number.toLowerCase().contains(query);
  }).toList();
}

@riverpod
class SelectedRecipient extends _$SelectedRecipient {
  @override
  WsContactDto? build() => null;
  
  void select(WsContactDto? contact) => state = contact;
}