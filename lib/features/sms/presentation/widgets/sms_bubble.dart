import 'package:dialcalink/core/database/drift/tables/sms_messages_table.dart';
import 'package:flutter/material.dart';
import 'package:dialcalink/core/utils/ui_date_formatter.dart';
import 'package:dialcalink/features/sms/domain/entities/sms_message_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SmsBubble extends ConsumerWidget {
  final SmsMessageEntity sms;

  const SmsBubble({super.key, required this.sms});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isOutgoing = sms.direction == SmsDirection.outgoing;    
    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isOutgoing 
              ? theme.colorScheme.primary.withValues(alpha: 0.9)
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomRight: isOutgoing ? const Radius.circular(4) : const Radius.circular(20),
            bottomLeft: isOutgoing ? const Radius.circular(20) : const Radius.circular(4),
          ),
          border: Border.all(
            color: isOutgoing 
                ? theme.colorScheme.primary.withValues(alpha: 0.2)
                : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          )
        ),
        child: Column(
          crossAxisAlignment: isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sms.content,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isOutgoing ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface
              )
            ),
            const SizedBox(height: 4),
            Text(
              formatRelativeTime(sms.receivedAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: isOutgoing 
                    ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                    : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6)
              ),
            ),
          ]
        )
      )
    );
  }
}
