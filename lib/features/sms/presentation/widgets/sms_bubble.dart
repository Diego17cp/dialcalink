import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dialcalink/core/utils/ui_date_formatter.dart';
import 'package:dialcalink/features/sms/domain/entities/sms_message_entity.dart';

class SmsBubble extends StatelessWidget {
  final SmsMessageEntity sms;

  const SmsBubble({super.key, required this.sms});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(4),
          ),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sms.content,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface
              )
            ),
            const SizedBox(height: 4),
            Text(
              formatRelativeTime(sms.receivedAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6)
              )
            )
          ]
        )
      )
    );
  }
}
