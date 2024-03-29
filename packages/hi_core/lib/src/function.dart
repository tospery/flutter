import 'package:flutter/material.dart';
import 'package:hi_core/src/extension/bool.dart';
import 'package:hi_core/src/extension/int.dart';
import 'package:hi_core/src/extension/string.dart';

Type typeOf<T>() => T;

bool isNotEmpty(String? text) => text?.isNotEmpty ?? false;
bool isEmpty(String? text) => text?.isEmpty ?? true;

bool? hiBool(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any;
  }
  if (any is int) {
    return any.toBool();
  }
  if (any is double) {
    return any.toInt().toBool();
  }
  if (any is String) {
    return any.toBool();
  }
  return null;
}

int? hiInt(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toInt();
  }
  if (any is int) {
    return any;
  }
  if (any is double) {
    return any.toInt();
  }
  if (any is String) {
    return any.toInt();
  }
  return null;
}

double? hiDouble(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toInt().toDouble();
  }
  if (any is int) {
    return any.toDouble();
  }
  if (any is double) {
    return any;
  }
  if (any is String) {
    return any.toDouble();
  }
  return null;
}

String? hiString(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is String) {
    return any;
  }
  if (any is bool) {
    return any.toString();
  }
  if (any is int) {
    return any.toString();
  }
  if (any is double) {
    return any.toString();
  }
  return null;
}

Map<String, dynamic>? hiMap(dynamic any) {
  if (any == null || any is! Map<String, dynamic>) {
    return null;
  }
  return any;
}

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