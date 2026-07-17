import 'package:dialcalink/app/theme/avatar/avatar_color_generator.dart';
import 'package:dialcalink/core/network/websocket/messages/payloads/ws_payloads.dart';
import 'package:flutter/material.dart';

class SuggestionsContact extends StatelessWidget {
  final WsContactDto contact;
  final VoidCallback? onTap;
  const SuggestionsContact({super.key, required this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarScheme = AvatarColorGenerator.fromSeed(contact.number);
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
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: avatarScheme.background,
                child: Text(
                  contact.name[0].toUpperCase(),
                  style: TextStyle(
                    color: avatarScheme.foreground,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        contact.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    
                    const SizedBox(height: 4),
                    Text(
                      contact.number,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 1.0,
                        ),
                        fontWeight: FontWeight.w500
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
