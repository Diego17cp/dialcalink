import 'package:dialcalink/app/router/app_router.dart';
import 'package:dialcalink/app/ui/widgets/update_progress_dialog.dart';
import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateConfirmationDialog extends ConsumerWidget {
  const UpdateConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return CupertinoAlertDialog(
      title: Text(l10n.updateDialogTitle),
      content: Text(l10n.updateDialogSubtitle),
      actions: [
        CupertinoDialogAction(
          child: Text(l10n.updateDialogLaterBtn),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(l10n.updateDialogUpdate),
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
