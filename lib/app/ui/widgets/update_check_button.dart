import 'package:dialcalink/app/ui/widgets/update_confirmation_dialog.dart';
import 'package:dialcalink/core/updates/providers/update_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateCheckButton extends ConsumerStatefulWidget {
  const UpdateCheckButton({super.key});

  @override
  ConsumerState<UpdateCheckButton> createState() => _UpdateCheckButtonState();
}

class _UpdateCheckButtonState extends ConsumerState<UpdateCheckButton> {
  bool _checking = false;

  Future<void> _handleTap() async {
    if (_checking) return;
    setState(() => _checking = true);

    try {
      ref.invalidate(latestReleaseProvider);
      ref.invalidate(updateAvailableProvider);

      final available = await ref.read(updateAvailableProvider.future);
      if (!mounted) return;

      if (available) {
        showDialog(
          context: context,
          builder: (_) => const UpdateConfirmationDialog(),
        );
      } else {
        final info = await PackageInfo.fromPlatform();
        _showSnack('Ya tienes la última versión ${info.version}.');
      }
    } catch (e) {
      if (mounted) {
        _showSnack('No se pudo verificar. Revisa tu conexión a internet.');
      }
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cachedAvailable =
        ref.watch(updateAvailableProvider).valueOrNull ?? false;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: _checking ? null : _handleTap,
        icon: _checking
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                cachedAvailable
                    ? CupertinoIcons.arrow_down_square
                    : CupertinoIcons.arrow_2_circlepath,
              ),
        label: Text(
          _checking
              ? 'Buscando...'
              : cachedAvailable
              ? 'Hay una actualización disponible'
              : 'Buscar actualizaciones',
        ),
      ),
    );
  }
}
