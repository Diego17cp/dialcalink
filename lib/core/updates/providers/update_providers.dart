import 'package:dialcalink/core/updates/apk_downloader.dart';
import 'package:dialcalink/core/updates/apk_installer_bridge.dart';
import 'package:dialcalink/core/updates/entities/latest_release.dart';
import 'package:dialcalink/core/updates/update_checker_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_providers.g.dart';

@riverpod
UpdateCheckerService updateCheckerService(Ref ref) => UpdateCheckerService();

@riverpod
ApkDownloader apkDownloader(Ref ref) => ApkDownloader();

@riverpod
ApkInstallerBridge apkInstallerBridge(Ref ref) => ApkInstallerBridge();

@riverpod
Future<LatestRelease?> latestRelease(Ref ref) async {
  final result = await ref
      .watch(updateCheckerServiceProvider)
      .fetchLatestRelease();
  return result.valueOrNull;
}

@riverpod
Future<bool> updateAvailable(Ref ref) async {
  final release = await ref.watch(latestReleaseProvider.future);
  if (release == null) return false;
  final info = await PackageInfo.fromPlatform();
  return ref
      .watch(updateCheckerServiceProvider)
      .isNewerVersion(release.tagName, info.version);
}

enum UpdateFlowStep { idle, downloading, readyToInstall, installing, error }

class UpdateFlowState {
  const UpdateFlowState({
    this.step = UpdateFlowStep.idle,
    this.progress = 0.0,
    this.errorMessage,
  });

  final UpdateFlowStep step;
  final double progress;
  final String? errorMessage;

  UpdateFlowState copyWith({
    UpdateFlowStep? step,
    double? progress,
    String? errorMessage,
  }) => UpdateFlowState(
    step: step ?? this.step,
    progress: progress ?? this.progress,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

@riverpod
class UpdateFlowController extends _$UpdateFlowController {
  @override
  UpdateFlowState build() => const UpdateFlowState();

  Future<void> downloadAndInstall(LatestRelease release) async {
    state = state.copyWith(step: UpdateFlowStep.downloading, progress: 0);

    final canInstall = await ref.read(apkInstallerBridgeProvider).canRequestInstallPackages();
    if (!canInstall) {
      await ref
          .read(apkInstallerBridgeProvider)
          .openInstallPermissionSettings();
      state = state.copyWith(
        step: UpdateFlowStep.error,
        errorMessage:
            'Habilita "Instalar apps desconocidas" para DialcaLink desde los ajustes y vuelve a intentarlo.',
      );
      return;
    }
    final downloadResult = await ref
        .read(apkDownloaderProvider)
        .download(
          release.apkDownloadUrl,
          onProgress: (p) => state = state.copyWith(progress: p),
        );
    final path = downloadResult.valueOrNull;
    if (path == null) {
      state = state.copyWith(
        step: UpdateFlowStep.error,
        errorMessage:
            downloadResult.failureOrNull?.message ?? 'Error al descargar',
      );
      return;
    }
    state = state.copyWith(step: UpdateFlowStep.installing);
    final installResult = await ref
        .read(apkInstallerBridgeProvider)
        .installApk(path);

    installResult.when(
      ok: (_) => state = state.copyWith(step: UpdateFlowStep.readyToInstall),
      failure: (f) => state = state.copyWith(
        step: UpdateFlowStep.error,
        errorMessage: f.message,
      ),
    );
  }
}
