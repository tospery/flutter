import 'package:flutter/material.dart';
import 'package:hi_core/src/extension/bool.dart';
import 'package:hi_core/src/extension/int.dart';
import 'package:hi_core/src/extension/string.dart';

Type typeOf<T>() => T;

bool isNotEmpty(String? text) => text?.isNotEmpty ?? false;
bool isEmpty(String? text) => text?.isEmpty ?? true;

bool? convertBool(dynamic data) {
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

int? convertInt(dynamic data) {
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

double? convertDouble(dynamic data) {
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

String? convertString(dynamic data) {
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

Map<K, V>? convertMap<K, V>(dynamic data) {
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

Map<String, dynamic>? convertJSON(dynamic data) => convertMap<String, dynamic>(data);
