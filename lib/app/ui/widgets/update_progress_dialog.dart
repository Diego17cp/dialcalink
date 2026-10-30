import 'package:dialcalink/core/extensions/l10n_extension.dart';
import 'package:dialcalink/core/updates/providers/update_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProgressDialog extends ConsumerStatefulWidget {
  const UpdateProgressDialog({super.key});

  @override
  ConsumerState<UpdateProgressDialog> createState() =>
      _UpdateProgressDialogState();
}

class _UpdateProgressDialogState extends ConsumerState<UpdateProgressDialog> {
  bool _isPopped = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startDownloadAndInstall();
    });
  }

  Future<void> _startDownloadAndInstall() async {
    try {
      final release = await ref.read(latestReleaseProvider.future);
      if (release != null && mounted) {
        await ref
            .read(updateFlowControllerProvider.notifier)
            .downloadAndInstall(release);
      } else {
        _closeDialog();
      }
    } catch (e) {
      debugPrint('[DIALCA][UPDATE] Error al descargar/instalar: $e');
      _closeDialog();
    }
  }

  void _closeDialog() {
    if (!_isPopped && mounted) {
      _isPopped = true;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateFlowControllerProvider);
    final l10n = context.l10n;

    if (state.step == UpdateFlowStep.readyToInstall && !_isPopped) {
      _isPopped = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    String statusText = l10n.updateProgressDownloading;
    Widget progressWidget = const CupertinoActivityIndicator();

    if (state.step == UpdateFlowStep.downloading) {
      statusText = '${l10n.updateProgressDownloadingPercent} ${(state.progress * 100).toStringAsFixed(0)}%';
      progressWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: state.progress,
            backgroundColor: CupertinoColors.systemGroupedBackground,
            valueColor: const AlwaysStoppedAnimation<Color>(
              CupertinoColors.activeBlue,
            ),
          ),
        ),
      );
    } else if (state.step == UpdateFlowStep.installing) {
      statusText = l10n.updateProgressInstalling;
    } else if (state.step == UpdateFlowStep.error) {
      statusText = state.errorMessage ?? l10n.unknownError;
      return CupertinoAlertDialog(
        title: Text(l10n.updateProgressError),
        content: Text(statusText),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.updateProgressCloseBtn),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }

    return CupertinoAlertDialog(
      title: Text(l10n.updateProgressUpdating),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          progressWidget,
          const SizedBox(height: 16),
          Text(
            statusText,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}