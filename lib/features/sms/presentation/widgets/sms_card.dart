import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notidialca/features/sms/domain/entities/sms_message_entity.dart';

class SmsCard extends StatelessWidget {
  final SmsMessageEntity sms;
  final String formattedTime;

  const SmsCard({super.key, required this.sms, required this.formattedTime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasContact = sms.contactName != null;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        onTap: () =>
            context.pushNamed('sms_conversation', pathParameters: {'phoneNumber': sms.phoneNumber}),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.5,
                ),
                child: hasContact
                    ? Text(
                        sms.contactName![0].toUpperCase(),
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : Icon(
                        CupertinoIcons.person_fill,
                        color: theme.colorScheme.primary,
                        size: 28,
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            sms.displayName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: sms.isRead ? FontWeight.w600 : FontWeight.w900,
                              color: theme.colorScheme.onSurface
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          formattedTime,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: sms.isRead
                              ? theme.colorScheme.onSurfaceVariant
                              : theme.colorScheme.primary,
                            fontWeight: sms.isRead ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sms.content,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: sms.isRead ? 0.7 : 1.0,
                        ),
                        fontWeight: sms.isRead ? FontWeight.normal : FontWeight.w500
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!sms.isRead)
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      )
                    ]
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
