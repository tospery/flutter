import 'package:flutter/material.dart';

extension ThemeDataEx on ThemeData {

  Color get bgColor => colorScheme.surface;          // 白色
  Color get fgColor => colorScheme.inverseSurface;   // 黑色

}