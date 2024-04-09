import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hi_core/src/extension/bool.dart';
import 'package:hi_core/src/extension/int.dart';
import 'package:hi_core/src/extension/string.dart';
import 'package:hi_core/src/logger.dart';

Type typeOf<T>() => T;

bool? tryBool(dynamic data) {
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

int? tryInt(dynamic data) {
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

double? tryDouble(dynamic data) {
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

String? tryString(dynamic data) {
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

Map<K, V>? tryMap<K, V>(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is Map<K, V>) {
    return data as Map<K, V>? ?? {};
  }
  if (data is! Map) {
    return null;
  }
  Map<K, V> map = {};
  data.forEach((k, value) {
    if (K == int) {
      final key = tryInt(k);
      if (key != null) {
        map[key as K] = value;
      }
    }
    if (K == double) {
      final key = tryDouble(k);
      if (key != null) {
        map[key as K] = value;
      }
    }
    if (K == String) {
      final key = tryString(k);
      if (key != null) {
        map[key as K] = value;
      }
    }
  });
  return map;
}

Map<String, dynamic>? tryJSON(dynamic data) => tryMap<String, dynamic>(data);

Color randomColor() => Color.fromRGBO(
  Random().nextInt(256),
  Random().nextInt(256),
  Random().nextInt(256),
  1,
);
