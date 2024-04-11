import 'dart:ui';
import 'package:flutter/material.dart';

extension ColorHiCoreEx on Color {

  String toHexString() {
    var string = '#${alpha.toRadixString(16).padLeft(2, '0')}';
    string += '${red.toRadixString(16).padLeft(2, '0')}';
    string += '${green.toRadixString(16).padLeft(2, '0')}';
    string += '${blue.toRadixString(16).padLeft(2, '0')}';
    return string;
  }

  Color get bgColor => computeLuminance() < 0.5 ? Colors.white : Colors.black;
  Color get fgColor => computeLuminance() < 0.5 ? Colors.black : Colors.white;

  Color get sd100 => computeLuminance() < 0.5 ? Colors.grey.shade100 : Colors.grey.shade900;
  Color get sd200 => computeLuminance() < 0.5 ? Colors.grey.shade200 : Colors.grey.shade800;
  Color get sd300 => computeLuminance() < 0.5 ? Colors.grey.shade300 : Colors.grey.shade700;
  Color get sd400 => computeLuminance() < 0.5 ? Colors.grey.shade400 : Colors.grey.shade500;
  Color get sd500 => Colors.grey.shade500;
  Color get sd600 => computeLuminance() < 0.5 ? Colors.grey.shade600 : Colors.grey.shade400;
  Color get sd700 => computeLuminance() < 0.5 ? Colors.grey.shade700 : Colors.grey.shade300;
  Color get sd800 => computeLuminance() < 0.5 ? Colors.grey.shade800 : Colors.grey.shade200;
  Color get sd900 => computeLuminance() < 0.5 ? Colors.grey.shade900 : Colors.grey.shade100;
  
}