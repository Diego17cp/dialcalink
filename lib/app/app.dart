import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/app/router/app_router.dart';
import 'package:dialcalink/app/theme/providers/theme_provider.dart';
import 'package:dialcalink/app/theme/theme.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}
class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final themeAsync = ref.watch(themeControllerProvider);
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'DialcaLink',
      themeMode: themeAsync.when(
        data: (mode) => mode,
        loading: () => ThemeMode.system,
        error: (_, __) => ThemeMode.system,
      ),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}