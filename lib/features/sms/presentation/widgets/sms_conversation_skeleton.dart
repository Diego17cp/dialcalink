import 'package:flutter/material.dart';

class SmsConversationSkeleton extends StatelessWidget {
  const SmsConversationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        final isShort = index % 2 == 0;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.4, end: 0.8),
          duration: const Duration(milliseconds: 1000 + (100 * 2)),
          builder: (context, value, child) =>
              Opacity(opacity: value, child: child),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: isShort ? 150 : 250,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }
}
