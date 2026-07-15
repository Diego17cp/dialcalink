import 'package:flutter/material.dart';

class SecondaryIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SecondaryIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.secondaryContainer,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(icon, color: theme.colorScheme.onSecondary, size: 20),
      ),
    );
  }
}
