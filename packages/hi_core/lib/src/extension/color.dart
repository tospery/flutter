import 'dart:ui';
import 'package:flutter/material.dart';

extension ColorHiCoreEx on Color {
  // String get hexString =>
  //     '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

  String toHexString() {
    var string = '#${alpha.toRadixString(16).padLeft(2, '0')}';
    string += '${red.toRadixString(16).padLeft(2, '0')}';
    string += '${green.toRadixString(16).padLeft(2, '0')}';
    string += '${blue.toRadixString(16).padLeft(2, '0')}';
    return string;
  }

  Color get bgColor => computeLuminance() < 0.5 ? Colors.white : Colors.black;
  Color get on100 => computeLuminance() < 0.5 ? Colors.grey.shade100 : Colors.grey.shade900;
  Color get on200 => computeLuminance() < 0.5 ? Colors.grey.shade200 : Colors.grey.shade800;
  Color get on300 => computeLuminance() < 0.5 ? Colors.grey.shade300 : Colors.grey.shade700;
  Color get on400 => computeLuminance() < 0.5 ? Colors.grey.shade400 : Colors.grey.shade500;
  Color get on500 => Colors.grey.shade500;
  Color get on600 => computeLuminance() < 0.5 ? Colors.grey.shade600 : Colors.grey.shade400;
  Color get on700 => computeLuminance() < 0.5 ? Colors.grey.shade700 : Colors.grey.shade300;
  Color get on800 => computeLuminance() < 0.5 ? Colors.grey.shade800 : Colors.grey.shade200;
  Color get on900 => computeLuminance() < 0.5 ? Colors.grey.shade900 : Colors.grey.shade100;
  Color get fgColor => computeLuminance() < 0.5 ? Colors.black : Colors.white;
}