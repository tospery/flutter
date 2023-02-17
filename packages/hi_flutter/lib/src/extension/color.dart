import 'package:flutter/material.dart';

extension ColorFlutterEx on Color {
  /// 背景色（白色->灰色->黑色）
  Color get canvasColor => computeLuminance() < 0.5 ? Colors.grey.shade50 : Colors.grey.shade50;
  Color get cardColor => computeLuminance() < 0.5 ? Colors.grey.shade100 : Colors.grey.shade100;
  Color get hoverColor => computeLuminance() < 0.5 ? Colors.grey.shade200 : Colors.grey.shade200;
  Color get splashColor => computeLuminance() < 0.5 ? Colors.grey.shade300 : Colors.grey.shade300;
  Color get highlightColor => computeLuminance() < 0.5 ? Colors.grey.shade400 : Colors.grey.shade400;
  Color get dividerColor => computeLuminance() < 0.5 ? Colors.grey : Colors.grey;
  Color get focusColor => computeLuminance() < 0.5 ? Colors.grey.shade600 : Colors.grey.shade600;
  Color get hintColor => computeLuminance() < 0.5 ? Colors.grey.shade700 : Colors.grey.shade700;
  Color get disabledColor => computeLuminance() < 0.5 ? Colors.grey.shade800 : Colors.grey.shade800;
  Color get shadowColor => computeLuminance() < 0.5 ? Colors.grey.shade900 : Colors.grey.shade900;
  /// 主题色
  Color get indicatorColor => this;
  /// 白色/黑色
  Color get surface => computeLuminance() < 0.5 ? Colors.white : Colors.black;
  Color get inverseSurface => computeLuminance() < 0.5 ? Colors.black : Colors.white;
}