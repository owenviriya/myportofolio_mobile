/// Base URL of the Django REST Framework backend.
///
/// Defaults to `http://10.0.2.2:8000` (IP address of your host PC that can be called from within Android emulator)
/// Override with `--dart-define=API_BASE_URL=http://localhost:8000` if you are testing on Chrome/Web browser
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);

/// Resolves image values returned by Django, including relative static paths
/// and Google Drive sharing links, into URLs that can be loaded by Flutter.
Uri? resolvePortfolioImageUri(String value) {
  final rawValue = value.trim();
  if (rawValue.isEmpty) return null;

  final uri = Uri.tryParse(rawValue);
  if (uri == null) return null;

  if (uri.hasScheme) {
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;

    if (uri.host.toLowerCase() == 'drive.google.com') {
      final fileId =
          uri.queryParameters['id'] ??
          RegExp(r'/file/d/([^/]+)').firstMatch(uri.path)?.group(1);
      if (fileId != null && fileId.isNotEmpty) {
        return Uri.https('drive.google.com', '/thumbnail', {
          'id': fileId,
          'sz': 'w1000',
        });
      }
    }

    return uri;
  }

  return Uri.parse(apiBaseUrl).resolve(rawValue);
}
