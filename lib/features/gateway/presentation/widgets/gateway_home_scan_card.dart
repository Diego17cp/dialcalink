import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GatewayHomeScanCard extends StatelessWidget {
  const GatewayHomeScanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: theme.colorScheme.outline,
          width: 1,
        )
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/gateway/home/pairing-qr') ,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: Icon(
                  CupertinoIcons.qrcode_viewfinder,
                  size: 50,
                  color: theme.colorScheme.primary,
                )
              ),
              const SizedBox(height: 16),
              Text(
                'Vincular Dispositivo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                )
              ),
              const SizedBox(height: 8),
              Text(
                'Muestra el código QR en el otro dispositivo para vincularlo con este.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                )
              ),
            ],
          )
        )
      )
    );
  }
}