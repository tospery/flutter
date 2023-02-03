import 'package:flutter/material.dart';

extension ColorEx on Color {
  String get hexString =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  Color get onColor => computeLuminance() < 0.5 ? Colors.white : Colors.black;
}
