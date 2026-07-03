import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/app/theme/providers/theme_provider.dart';

class ThemeSelectionSheet extends ConsumerWidget {
  const ThemeSelectionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeControllerProvider);
    final currentTheme = themeAsync.when(
      data: (mode) => mode,
      loading: () => ThemeMode.system,
      error: (_, __) => ThemeMode.system,
    );
    final changeTheme = ref.read(themeControllerProvider.notifier).changeTheme;

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withAlpha(100),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Aspecto de la aplicación',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _ThemeOption(
            title: 'Sistema',
            icon: CupertinoIcons.device_phone_portrait,
            isSelected: currentTheme == ThemeMode.system,
            onTap: () {
              changeTheme(ThemeMode.system);
              Navigator.of(context).pop();
            },
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 8),
          _ThemeOption(
            title: 'Claro',
            icon: CupertinoIcons.sun_min,
            isSelected: currentTheme == ThemeMode.light,
            onTap: () {
              changeTheme(ThemeMode.light);
              Navigator.of(context).pop();
            },
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 8),
          _ThemeOption(
            title: 'Oscuro',
            icon: CupertinoIcons.moon,
            isSelected: currentTheme == ThemeMode.dark,
            onTap: () {
              changeTheme(ThemeMode.dark);
              Navigator.of(context).pop();
            },
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _ThemeOption({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
            ),
            if (isSelected)
              Icon(CupertinoIcons.checkmark_alt_circle_fill, color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
