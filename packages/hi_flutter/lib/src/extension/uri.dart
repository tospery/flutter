import 'map.dart';

extension UriEx on Uri {
  String get hostpath => host + path;

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
