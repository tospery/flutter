import 'package:flutter/material.dart';

extension ColorFlutterEx on Color {
  Color get secondaryColor => Colors.blue;
  Color get hintColor => computeLuminance() < 0.5 ? Colors.grey : Colors.grey;
  Color get dividerColor => computeLuminance() < 0.5 ? Colors.grey.shade300 : Colors.grey.shade300;
  Color get scaffoldBackgroundColor => computeLuminance() < 0.5 ? Colors.grey.shade100 : Colors.grey.shade100;
}