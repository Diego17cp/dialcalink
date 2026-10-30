import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dialcalink/features/pairing/presentation/providers/client_pairing_state.dart';

class PairingStatusCard extends StatelessWidget {
  final ClientPairingPhase phase;
  final String? errorMessage;

  const PairingStatusCard({super.key, required this.phase, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    IconData icon = CupertinoIcons.qrcode_viewfinder;
    String title = l10n.pairingStatusSearchingTitle;
    String subtitle = l10n.pairingStatusSearchingSubtitle;
    Color color = theme.colorScheme.primary;

    if (phase == ClientPairingPhase.verifying) {
      icon = CupertinoIcons.arrow_2_circlepath;
      title = l10n.pairingStatusVerifyingTitle;
      subtitle = l10n.pairingStatusVerifyingSubtitle;
    } else if (phase == ClientPairingPhase.invalidQr) {
      icon = CupertinoIcons.xmark_circle;
      title = l10n.pairingStatusInvalidQRTitle;
      subtitle = l10n.pairingStatusInvalidQRSubtitle;
      color = theme.colorScheme.error;
    } else if (phase == ClientPairingPhase.failed) {
      icon = CupertinoIcons.exclamationmark_triangle;
      title = l10n.pairingStatusFailedTitle;
      subtitle = errorMessage ?? l10n.pairingStatusFailedSubtitle;
      color = theme.colorScheme.error;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            if (phase == ClientPairingPhase.verifying)
              const CircularProgressIndicator(strokeWidth: 2)
            else
              Icon(icon, size: 28, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
