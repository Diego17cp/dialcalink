import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notidialca/core/database/drift/tables/devices_table.dart';
import 'package:notidialca/core/identity/providers/device_identity_provider.dart';
import 'package:notidialca/features/onboarding/presentation/widgets/device_role_selection_card.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter/cupertino.dart';

@Preview(name: 'Onboarding - Selección de Rol', group: 'Onboarding')
Widget previewOnboardingRoleSelection() {
  return const MaterialApp(home: OnboardingRoleSelectionScreen());
}

class OnboardingRoleSelectionScreen extends ConsumerStatefulWidget {
  const OnboardingRoleSelectionScreen({super.key});

  @override
  ConsumerState<OnboardingRoleSelectionScreen> createState() =>
      _OnboardingRoleSelectionScreenState();
}

class _OnboardingRoleSelectionScreenState
    extends ConsumerState<OnboardingRoleSelectionScreen> {
  DeviceRole _selectedRole = DeviceRole.client;
  void _onRoleSelected(DeviceRole role) => setState(() {
    _selectedRole = role;
  });
  void _onContinuePressed() async {
    final service = await ref.read(deviceIdentityServiceProvider.future);
    await service.setRole(_selectedRole);
    ref.invalidate(localDeviceIdentityProvider);
    if (!mounted) return;
    context.go('/onboarding/permissions/${_selectedRole.name}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    isDark
                        ? 'assets/images/dialcalink_icon_white.png'
                        : 'assets/images/dialcalink_icon_black.png',
                    width: 80,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Bienvenido a DialcaLink',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selecciona cómo utilizarás este dispositivo.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Podrás cambiar esta configuración más adelante.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  DeviceRoleSelectionCard(
                    role: DeviceRole.client,
                    selectedRole: _selectedRole,
                    onSelected: _onRoleSelected,
                  ),
                  const SizedBox(height: 16),
                  DeviceRoleSelectionCard(
                    role: DeviceRole.gateway,
                    selectedRole: _selectedRole,
                    onSelected: _onRoleSelected,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _onContinuePressed,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Continuar'),
                          SizedBox(width: 8),
                          Icon(CupertinoIcons.arrowtriangle_right_fill, size: 16),
                        ],
                      ),
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
