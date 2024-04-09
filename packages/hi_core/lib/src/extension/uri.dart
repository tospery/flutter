import 'map.dart';

extension UriHiCoreEx on Uri {
  String get hostpath => host + path;
  String get route {
    var result = host;
    if (result.isEmpty) {
      return result;
    }
    if (path.isNotEmpty) {
      result += '$path';
    }
    if (query.isNotEmpty) {
      result += '?$query';
    }
    return '/$result';
  }

  bool get isValidHttpUrl => [
    'https', 'http'
  ].contains(this.scheme.toLowerCase());

  bool get isValidImageUrl => [
    'jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'
  ].contains(this.pathSegments.last.split('.').last.toLowerCase());

  bool get isValidMarkdownUrl => [
    'md', 'mdx'
  ].contains(this.pathSegments.last.split('.').last.toLowerCase());

  bool get isValidFileUrl => this.pathSegments.last.contains('.');

  Uri removeAllQueries() {
    var result = this.replace(queryParameters: {});
    if (result.query.isEmpty && result.hasQuery) {
      final string = result.toString();
      final uri = Uri.tryParse(string.substring(0, string.length - 1));
      if (uri != null) {
        result = uri;
      }
    }
    return result;
  }

  Uri removeLastPath() {
    var paths = List<String>.from(this.pathSegments);
    if (paths.isNotEmpty) {
      paths.removeLast();
      return this.replace(pathSegments: paths);
    }
    return this;
  }

  Uri ensureTrailingSlash() {
    if (!this.path.endsWith('/')) {
      String newPath = '${this.path}/';
      return this.replace(path: newPath);
    }
    return this;
  }

  Uri add({required Map<String, String> queries}) {
    Map<String, dynamic> parameters = {};
    parameters.addAll(queryParameters);
    parameters.addAll(queries);
    return Uri(
        scheme: scheme, host: host, path: path, queryParameters: parameters);
  }

  Uri addIfNotExist({required Map<String, String> queries}) {
    if (queries.isEmpty) {
      return this;
    }
    var parameters = queryParameters;
    parameters = parameters.addIfNotExist(queries);
    return Uri(
        scheme: scheme, host: host, path: path, queryParameters: parameters);
  }

  static Uri uri({
    required String host,
    String? path,
    Map<String, String>? queries,
  }) {
    return Uri.https(host, path ?? '', queries);
  }
}
