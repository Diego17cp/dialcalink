import 'dart:convert';

import 'package:dialcalink/core/failures/failure.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:dialcalink/core/updates/entities/latest_release.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class UpdateCheckerService {

  static const owner = "Diego17cp";
  static const repo = "dialcalink";

  UpdateCheckerService({http.Client? client, Logger? logger})
    : _client = client ?? http.Client(),
      _logger = logger ?? Logger();

  final http.Client _client;
  final Logger _logger;

  Future<Result<LatestRelease?>> fetchLatestRelease() async {
    final url = Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest');
    try {
      final response = await _client
        .get(url, headers: {'Accept': 'application/vnd.github+json'})
        .timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 404) {
        _logger.w('UpdateCheckerService: no hay releases publicados actualmente.');
        return Result.ok(null);
      }
      if (response.statusCode != 200) {
        return Result.failure(
          NetworkFailure('Github respondió con código ${response.statusCode}')
        );
      }
      
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final assets = (json['assets'] as List<dynamic>? ?? []);
      final apkAsset = assets.cast<Map<String, dynamic>>().firstWhere(
        (a) => (a['name'] as String? ?? '').endsWith('.apk'),
        orElse: () => const {} as Map<String, dynamic>
      );

      if (apkAsset.isEmpty) {
        _logger.w('UpdateCheckerService: no se encontró el asset .apk');
        return Result.ok(null);
      }

      final releaseName = (json['tag_name'] as String? ?? '').replaceFirst('v', '');
      final downloadUrl = apkAsset['browser_download_url'] as String;
      final releaseNotes = json['body'] as String? ?? '';
      final publishedAt = DateTime.tryParse(json['published_at'] as String? ?? '') ?? DateTime.now();

      return Result.ok(
        LatestRelease(
          tagName: releaseName,
          apkDownloadUrl: downloadUrl,
          releaseNotes: releaseNotes,
          publishedAt: publishedAt,
        )
      );
    } catch (e) {
      _logger.e('UpdateCheckerService error', error: e);
      return Result.failure(
        NetworkFailure('Error al verificar actualizaciones', cause: e)
      );
    }
  }

  bool isNewerVersion(String latest, String current) {
    final latestParts = _parseVersion(latest);
    final currentParts = _parseVersion(current);
    for (var i = 0; i < 3; i++) {
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }
    return false;
  }

  List<int> _parseVersion(String version) {
    final clean = version.split('+').first;
    final parts = clean.split('.').map((p) => int.tryParse(p) ?? 0).toList();
    while (parts.length < 3) {
      parts.add(0);
    }
    return parts;
  }
}
