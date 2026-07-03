import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dialcalink/app/layouts/widgets/theme_selection_sheet.dart';
import 'package:dialcalink/shared/glass_icon_button.dart';

class ThemeTogglerButton extends StatelessWidget {
  const ThemeTogglerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassIconButton(
      icon: CupertinoIcons.circle_lefthalf_fill,
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: theme.colorScheme.surface,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        builder: (context) => const ThemeSelectionSheet(),
      ),
    );
  }
}
