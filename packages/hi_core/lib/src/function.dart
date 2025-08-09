import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hi_core/src/error.dart';

HiError forceError(dynamic data) {
  if (data is HiError) {
    return data;
  }
  return HiError.unknown;
}

Color randomColor() => Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );
