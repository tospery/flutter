import 'package:flutter/material.dart';
import 'package:hi_core/src/extension/color.dart';

extension ThemeDataHiCoreEx on ThemeData {

  Color get bgColor => cardColor;   // colorScheme.surface;          // 白色
  // Color get on100 => fgColor.on100;
  // Color get on200 => fgColor.on200;
  // Color get on300 => fgColor.on300;
  // Color get on400 => fgColor.on400;
  // Color get on500 => fgColor.on500;
  // Color get on600 => fgColor.on600;
  // Color get on700 => fgColor.on700;
  // Color get on800 => fgColor.on800;
  // Color get on900 => fgColor.on900;
  Color get fgColor => shadowColor; // colorScheme.inverseSurface;   // 黑色

  TextStyle bgTextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: bgColor);
  TextStyle fgTextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor);
  
  TextStyle on100TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on100);
  TextStyle on200TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on200);
  TextStyle on300TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on300);
  TextStyle on400TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on400);
  TextStyle on500TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on500);
  TextStyle on600TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on600);
  TextStyle on700TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on700);
  TextStyle on800TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on800);
  TextStyle on900TextStyle(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.on900);
}