import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GatewayPairingIdentityFailed extends StatelessWidget {
  const GatewayPairingIdentityFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.exclamationmark_triangle_fill,
          size: 64,
          color: theme.colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.onboardingGatewayErrorNoIdentity,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.attemptAgain,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}