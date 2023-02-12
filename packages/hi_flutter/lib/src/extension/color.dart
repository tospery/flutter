import 'package:flutter/material.dart';

extension ColorFlutterEx on Color {
  Color get dividerColor => computeLuminance() < 0.5 ? Colors.red : Colors.green;
}