import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notidialca/core/utils/ui_date_formatter.dart';
import 'package:notidialca/features/sms/presentation/providers/sms_providers.dart';
import 'package:notidialca/features/sms/presentation/widgets/empty_sms_list.dart';
import 'package:notidialca/features/sms/presentation/widgets/sms_card.dart';
import 'package:notidialca/features/sms/presentation/widgets/sms_skeleton.dart';

class SmsListScreen extends ConsumerWidget {
  const SmsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(allSmsMessagesProvider);
    return messagesAsync.when(
      data: (messages) {
        if (messages.isEmpty) {
          return const EmptySmsList();
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final sms = messages[index];
            return SmsCard(
              sms: sms,
              formattedTime: formatRelativeTime(sms.receivedAt),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('Error: $error'),
        );
      },
      loading: () => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) => const SmsSkeleton(),
      ),
    );
  }
}