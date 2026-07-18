import 'package:dialcalink/app/router/app_router.dart';
import 'package:dialcalink/app/ui/widgets/loading_screen.dart';
import 'package:dialcalink/app/ui/widgets/update_confirmation_dialog.dart';
import 'package:dialcalink/core/updates/providers/update_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUpdates();
  }

  void _checkUpdates() {
    ref
        .read(updateAvailableProvider.future)
        .then((available) {
          if (available) {
            final globalContext = rootNavigatorKey.currentContext;
            if (globalContext != null && globalContext.mounted) {
              showCupertinoDialog(
                context: globalContext,
                barrierDismissible: false,
                builder: (dialogContext) => const UpdateConfirmationDialog(),
              );
            }
          }
        })
        .catchError((error) {
          debugPrint(
            '[DIALCA][UPDATE] Error al verificar actualizaciones: $error',
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
