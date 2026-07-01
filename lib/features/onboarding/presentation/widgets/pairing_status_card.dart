import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notidialca/features/pairing/presentation/providers/client_pairing_state.dart';

class PairingStatusCard extends StatelessWidget {
  final ClientPairingPhase phase;
  final String? errorMessage;

  const PairingStatusCard({super.key, required this.phase, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    IconData icon = CupertinoIcons.qrcode_viewfinder;
    String title = 'Buscando código QR';
    String subtitle = 'Apunta al código QR para iniciar el emparejamiento.';
    Color color = theme.colorScheme.primary;

    if (phase == ClientPairingPhase.verifying) {
      icon = CupertinoIcons.arrow_2_circlepath;
      title = 'Verificando...';
      subtitle = 'Validando conexión con el dispositivo.';
    } else if (phase == ClientPairingPhase.invalidQr) {
      icon = CupertinoIcons.xmark_circle;
      title = 'Código QR inválido';
      subtitle = 'Este QR no es de un DialcaLink válido.';
      color = theme.colorScheme.error;
    } else if (phase == ClientPairingPhase.failed) {
      icon = CupertinoIcons.exclamationmark_triangle;
      title = 'Error de emparejamiento';
      subtitle = errorMessage ?? 'Ocurrió un error durante el emparejamiento.';
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
