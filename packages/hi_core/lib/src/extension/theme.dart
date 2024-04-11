import 'package:flutter/material.dart';
import 'package:hi_core/src/extension/color.dart';

extension ThemeDataHiCoreEx on ThemeData {

  Color get bgColor => cardColor;   // colorScheme.surface;          // 白色
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