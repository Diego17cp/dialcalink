import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/features/sms/presentation/providers/sms_providers.dart';

class DeleteConversationDialog extends ConsumerWidget {
  final String displayName;
  final String phoneNumber;

  const DeleteConversationDialog({super.key, required this.displayName, required this.phoneNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('Eliminar conversación'),
      content: Text(
        'Se eliminarán todos los mensajes con $displayName. Esta acción no se puede deshacer.',
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () async {
            await ref.read(deleteConversationProvider(phoneNumber));
            Navigator.of(context).pop();
          },
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}