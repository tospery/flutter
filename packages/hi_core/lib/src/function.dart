import 'package:flutter/material.dart';
import 'package:hi_core/src/extension/bool.dart';
import 'package:hi_core/src/extension/int.dart';
import 'package:hi_core/src/extension/string.dart';

Type typeOf<T>() => T;

bool isNotEmpty(String? text) => text?.isNotEmpty ?? false;
bool isEmpty(String? text) => text?.isEmpty ?? true;

bool? convert2Bool(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is bool) {
    return data;
  }
  if (data is int) {
    return data.toBool();
  }
  if (data is double) {
    return data.toInt().toBool();
  }
  if (data is String) {
    return data.toBool();
  }
  return null;
}

int? convert2Int(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is bool) {
    return data.toInt();
  }
  if (data is int) {
    return data;
  }
  if (data is double) {
    return data.toInt();
  }
  if (data is String) {
    return data.toInt();
  }
  return null;
}

double? convert2Double(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is bool) {
    return data.toInt().toDouble();
  }
  if (data is int) {
    return data.toDouble();
  }
  if (data is double) {
    return data;
  }
  if (data is String) {
    return data.toDouble();
  }
  return null;
}

String? convert2String(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is String) {
    return data;
  }
  if (data is bool) {
    return data.toString();
  }
  if (data is int) {
    return data.toString();
  }
  if (data is double) {
    return data.toString();
  }
  return null;
}

Map<K, V>? convert2Map<K, V>(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is Map<K, V>) {
    return data as Map<K, V>? ?? {};
  }
  if (data is! Map<dynamic, dynamic>) {
    return null;
  }
  Map<K, V> map = {};
  data.forEach((key, value) {
    if (key is K && value is V) {
      map[key] = value;
    }
  });
  return map;
}

Map<String, dynamic>? convert2JSON(dynamic data) => convert2Map<String, dynamic>(data);

// List<T>? hiList<T>(dynamic any) {
//   if (any == null) {
//     return null;
//   }
//   if (any is! List<dynamic>) {
//     return null;
//   }
//   var list = any.cast<T>();
//   return list;
// }
//
// T? hiEnum<T>(dynamic any, T Function(dynamic) fromValue) {
//   if (any == null) {
//     return null;
//   }
//   if (any is T) {
//     return any as T;
//   }
//   return fromValue(any);
// }