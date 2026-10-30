import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/material.dart';

class GatewayPairingPin extends StatelessWidget {
  const GatewayPairingPin({super.key, required this.pin});

  final String pin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          l10n.gatewayPairPINHint,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            pin,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
