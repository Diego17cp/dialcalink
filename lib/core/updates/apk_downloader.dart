import 'dart:io';

import 'package:dialcalink/core/failures/failure.dart';
import 'package:dialcalink/core/failures/result.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class ApkDownloader {
  ApkDownloader({http.Client? client, Logger? logger})
    : _client = client ?? http.Client(),
      _logger = logger ?? Logger();

  final http.Client _client;
  final Logger _logger;

  Future<Result<String>> download(
    String url, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/dialcalink_update.apk';
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
      final request = http.Request('GET', Uri.parse(url));
      final response = await _client.send(request);
      if (response.statusCode != 200) {
        return Result.failure(
          NetworkFailure('Descarga fallida: ${response.statusCode}'),
        );
      }
      final total = response.contentLength ?? 0;
      var received = 0;
      final sink = file.openWrite();

      await response.stream.listen((chunk) {
        received += chunk.length;
        sink.add(chunk);
        if (total > 0) {
          onProgress?.call(received / total);
        }
      }).asFuture<void>();

      await sink.close();
      return Result.ok(filePath);
    } catch (e) {
      _logger.e('ApkDownloader: error al descargar el APK', error: e);
      return Result.failure(
        NetworkFailure('Error al descargar el APK', cause: e),
      );
    }
  }
}
