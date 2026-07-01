import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    isDark
                        ? 'assets/images/dialcalink_icon_white.png'
                        : 'assets/images/dialcalink_icon_black.png',
                    width: 80,
                  ),
                  const SizedBox(height: 32),
                  Badge(
                    label: const Text('Bienvenido'),
                    backgroundColor: theme.colorScheme.secondary,
                    textColor: theme.colorScheme.secondaryContainer,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Recibe tus SMS y llamadas en un solo lugar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Conecta dos dispositivos Android para centralizar toda tu actividad telefónica.',
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Image.asset('assets/images/onboarding_welcome.png', width: 200),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              Icon(CupertinoIcons.link, color: theme.colorScheme.primary, size: 20),
                              Text(
                                '¿Cómo funciona?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'El dispositivo con SIM comparte SMS y llamadas mediante tu red Wi-Fi local. Tu dispositivo principal recibe en tiempo real.',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: theme.colorScheme.outline,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(CupertinoIcons.shield, color: theme.colorScheme.primary, size: 20),
                          Text(
                            'Tu información permanece dentro de tu red\nlocal. '
                            'No utilizamos servidores externos.',
                            style: TextStyle(
                              fontSize: 10,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.go('/onboarding/role-selection'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: const Text('Comenzar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
