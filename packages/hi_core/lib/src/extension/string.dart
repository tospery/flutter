import 'dart:ui';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'int.dart';
import 'package:hi_core/hi_core.dart';

extension StringHiCoreEx on String {
  String get base64Decoded => convert.utf8.decode(convert.base64.decode(replaceAll(RegExp(r'\s+'), '')));

  bool? toBool() {
    if (toLowerCase() == 'true') {
      return true;
    }
    if (toLowerCase() == 'false') {
      return false;
    }
    return toInt()?.toBool();
  }

  int? toInt() => int.tryParse(this);

  double? toDouble() => double.tryParse(this);

  // dynamic toJson() {
  //   return isNotEmpty ? convert.json.decode(this) : <String, dynamic>{};
  // }

  Color? toColor() {
    var hexString = toUpperCase().replaceAll('#', '');
    if (hexString.length == 6) {
      hexString += 'FF';
    }
    var intValue = int.tryParse(hexString, radix: 16);
    if (intValue == null) {
      return null;
    }
    return Color(intValue);

    // if (length < 7) {
    //   return null;
    // }
    // return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }

  Uri? toUri() => Uri.tryParse(this);

  String? get baseURL {
    final uri = toUri();
    if (uri == null) {
      return null;
    }
    return "${uri.scheme}://${uri.host}";
  }

  String? get urlPath => toUri()?.path;

  Map<String, String>? get urlQueries => toUri()?.queryParameters;

  String? toRoute() {
    final uri = toUri();
    if (uri == null || uri.host.isEmpty) {
      // 邮件
      var prefix = 'mailto:';
      if (this.startsWith(prefix) ) {
        return this;
      }
      if (this.isValidEmail) {
        return prefix + this;
      }
      log('HTTP URL转Route URL失败', tag: HiLogTag.navigator);
      return null;
    }
    var route = uri.host;
    final path = uri.path;
    if (path.isNotEmpty) {
      route += '$path';
    }
    final query = uri.query;
    if (query.isNotEmpty) {
      route += '?$query';
    }
    return '/$route';
  }

  bool get isValidThirdUrl {
    if (this.isValidHttpUrl) {
      return false;
    }
    final items = this.split(':');
    if (items.length <= 1) {
      return false;
    }
    if (items.first.isEmpty) {
      return false;
    }
    if (items.second.isEmpty) {
      return false;
    }
    return true;
  }

  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidHttpUrl => [
    'https', 'http'
  ].contains(this.toUri()?.scheme.toLowerCase());

  bool get isValidImageUrl => [
    'jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'
  ].contains(this.toUri()?.pathSegments.last.split('.').last.toLowerCase());

  bool get isValidMarkdownUrl => [
    'md', 'mdx'
  ].contains(this.toUri()?.pathSegments.last.split('.').last.toLowerCase());

  // bool get isValidFileExUrl => this.toUri()?.pathSegments.last.contains('.');

  String take(String value) {
    var result = '';
    var items = split('/');
    for (var item in items) {
      if (item.isEmpty) {
        continue;
      }
      if (item.startsWith(':')) {
        result += '/$value';
      } else {
        result += '/$item';
      }
    }
    return result;
  }

  String toJsonString() => convert.json.encode(this);
  Map<String, dynamic>? toJsonObject() {
    try {
      var json = convert.json.decode(this);
      if (json is! Map<String, dynamic>) {
        return null;
      }
      return json;
    } catch (e) {
      return null;
    }
  }

  List<dynamic>? toJsonArray() {
    try {
      var json = convert.json.decode(this);
      if (json is! List<dynamic>) {
        return null;
      }
      return json;
    } catch (e) {
      return null;
    }
  }

  dynamic toJson() {
    var object = toJsonObject();
    if (object?.isNotEmpty ?? false) {
      return object;
    }
    var array = toJsonArray();
    if (array?.isNotEmpty ?? false) {
      return array;
    }
    return null;
  }

  int get _colorHash {
    int hash = 0;
    runes.forEach((code) {
      hash = code + ((hash << 5) - hash);
    });
    return hash;
  }

  int get _hexInt {
    String c = (_colorHash & 0x00FFFFFF).toRadixString(16).toUpperCase();
    String hex = "FF00000".substring(0, 8 - c.length) + c;
    return int.parse(hex, radix: 16);
  }

  Color get fixedColor => Color(_hexInt);

  List<String> splitChunk(int chunkSize) {
    List<String> chunks = [];
    int startIndex = 0;

    while (startIndex < this.length) {
      int endIndex = startIndex + chunkSize;
      if (endIndex > this.length) {
        endIndex = this.length;
      }
      chunks.add(this.substring(startIndex, endIndex));
      startIndex = endIndex;
    }

    return chunks;
  }

  String appendURLQueries(Map<String, String> queries) {
    final uri = toUri();
    if (uri == null) {
      return this;
    }
    var existing = Uri.splitQueryString(uri.query);
    existing.addAll(queries);
    return uri.replace(queryParameters: existing).toString();
  }

  String? get urlHostpath {
    final uri = toUri();
    if (uri == null) {
      return null;
    }
    return uri.host + uri.path;
  }

  String removeAllQueries() {
    final uri = toUri();
    if (uri == null) {
      return this;
    }
    var result = uri.replace(queryParameters: null);
    if (result.hasQuery) {
      final string = result.toString();
      final current = Uri.tryParse(string.substring(0, string.length - 1));
      if (current != null) {
        result = current;
      }
    }
    return result.toString();
  }

  String removeLastPath() {
    final uri = toUri();
    if (uri == null) {
      return this;
    }
    var paths = List<String>.from(uri.pathSegments);
    if (paths.isNotEmpty) {
      paths.removeLast();
      return uri.replace(pathSegments: paths).toString();
    }
    return this;
  }

  String ensureTrailingSlash() {
    final uri = toUri();
    if (uri == null) {
      return this;
    }
    if (!uri.path.endsWith('/')) {
      String newPath = '${uri.path}/';
      return uri.replace(path: newPath).toString();
    }
    return this;
  }

}
