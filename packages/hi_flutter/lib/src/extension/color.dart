import 'package:flutter/material.dart';

extension ColorFlutterEx on Color {
  /// 背景色（白色->灰色->黑色）
  Color get bgColor => computeLuminance() < 0.5 ? Colors.white : Colors.black;
  Color get canvasColor => computeLuminance() < 0.5 ? Colors.grey[50]! : Colors.grey[50]!;
  Color get cardColor => computeLuminance() < 0.5 ? Colors.grey[100]! : Colors.grey[100]!;
  Color get hoverColor => computeLuminance() < 0.5 ? Colors.grey[200]! : Colors.grey[200]!;
  Color get splashColor => computeLuminance() < 0.5 ? Colors.grey[300]! : Colors.grey[300]!;
  Color get highlightColor => computeLuminance() < 0.5 ? Colors.grey[350]! : Colors.grey[350]!;
  Color get dividerColor => computeLuminance() < 0.5 ? Colors.grey[400]! : Colors.grey[400]!;
  Color get greyColor => computeLuminance() < 0.5 ? Colors.grey : Colors.grey;
  Color get indicatorColor => computeLuminance() < 0.5 ? Colors.grey[600]! : Colors.grey[600]!;
  Color get focusColor => computeLuminance() < 0.5 ? Colors.grey[700]! : Colors.grey[700]!;
  Color get hintColor => computeLuminance() < 0.5 ? Colors.grey[800]! : Colors.grey[800]!;
  Color get disabledColor => computeLuminance() < 0.5 ? Colors.grey[850]! : Colors.grey[850]!;
  Color get shadowColor => computeLuminance() < 0.5 ? Colors.grey[900]! : Colors.grey[900]!;
  Color get fgColor => computeLuminance() < 0.5 ? Colors.black : Colors.white;
}