import 'package:flutter/material.dart';
import 'package:notidialca/app/layouts/widgets/theme_selection_sheet.dart';
import 'package:notidialca/core/permissions/app_permission.dart';
import 'package:flutter/cupertino.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final AppRole role;
  final String? title;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  
  const BaseScaffold({
    super.key, 
    required this.child,
    required this.role,
    this.title,
    this.actions,
    this.bottomNavigationBar
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayTitle = title ?? 'DialcaLink ${role == AppRole.gateway ? 'Gateway' : 'Cliente'}';
    return Scaffold(
      appBar: AppBar(
        title: Text(displayTitle),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        actions: [
          ...?actions,
          IconButton(
            icon: const Icon(CupertinoIcons.circle_lefthalf_fill),
            tooltip: 'Cambiar tema',
            onPressed: () => showModalBottomSheet(
              context: context,
              backgroundColor: theme.colorScheme.surface,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              builder: (context) => const ThemeSelectionSheet()
            )
          )
        ]
      ),
      body: child,
        bottomNavigationBar: bottomNavigationBar
    );
  }
}