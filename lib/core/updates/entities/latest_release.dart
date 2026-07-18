class LatestRelease {
  const LatestRelease ({
    required this.tagName,
    required this.apkDownloadUrl,
    required this.releaseNotes,
    required this.publishedAt,
  });

  final String tagName;
  final String apkDownloadUrl;
  final String releaseNotes;
  final DateTime publishedAt;
}