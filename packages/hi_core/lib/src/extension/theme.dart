import 'package:flutter/material.dart';
import 'package:hi_core/src/extension/color.dart';

extension ThemeDataEx on ThemeData {

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

  TextStyle tsBg(double fontSize) => TextStyle(fontSize: fontSize, color: bgColor);
  TextStyle tsFg(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor);
  
  TextStyle ts100(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd100);
  TextStyle ts200(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd200);
  TextStyle ts300(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd300);
  TextStyle ts400(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd400);
  TextStyle ts500(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd500);
  TextStyle ts600(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd600);
  TextStyle ts700(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd700);
  TextStyle ts800(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd800);
  TextStyle ts900(double fontSize) => TextStyle(fontSize: fontSize, color: fgColor.sd900);
}