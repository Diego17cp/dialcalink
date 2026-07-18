import 'package:dialcalink/app/router/app_router.dart';
import 'package:dialcalink/app/ui/widgets/update_progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateConfirmationDialog extends ConsumerWidget {
  const UpdateConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('Actualización Disponible'),
      content: const Text(
        'Hay una nueva versión de DialcaLink disponible. ¿Deseas descargarla e instalarla ahora?',
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Más tarde'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Actualizar'),
          onPressed: () {
            Navigator.of(context).pop();
            final globalContext = rootNavigatorKey.currentContext;
            if (globalContext != null && globalContext.mounted) {
              showCupertinoDialog(
                context: globalContext,
                barrierDismissible: false,
                builder: (dialogContext) => const UpdateProgressDialog(),
              );
            }
          },
        ),
      ],
    );
  }
}
