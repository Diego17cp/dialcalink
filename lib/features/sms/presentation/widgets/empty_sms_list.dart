import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widget_previews.dart';

@Preview(
  name: 'Empty SMS',
  group: 'SMS',
)
Widget emptySmsPreview() {
  return const MaterialApp(
    home: Scaffold(
      body: EmptySmsList(),
    ),
  );
}

class EmptySmsList extends StatelessWidget {
  const EmptySmsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.bubble_left_bubble_right,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.clientSmsListEmptyTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.clientSmsListEmptySubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
          )
        ],
      ),
    );
  }
}