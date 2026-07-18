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

    if (state.step == UpdateFlowStep.readyToInstall && !_isPopped) {
      _isPopped = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    String statusText = 'Descargando actualización...';
    Widget progressWidget = const CupertinoActivityIndicator();

    if (state.step == UpdateFlowStep.downloading) {
      statusText = 'Descargando ${(state.progress * 100).toStringAsFixed(0)}%';
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
      statusText = 'Preparando instalación...';
    } else if (state.step == UpdateFlowStep.error) {
      statusText = state.errorMessage ?? 'Ocurrió un error inesperado.';
      return CupertinoAlertDialog(
        title: const Text('Error de actualización'),
        content: Text(statusText),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }

    return CupertinoAlertDialog(
      title: const Text('Actualizando DialcaLink'),
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