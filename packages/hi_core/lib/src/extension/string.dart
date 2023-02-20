import 'dart:ui';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'int.dart';

extension StringEx on String {
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

  bool get isWebScheme => startsWith('http://') || startsWith('https://');

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
}
