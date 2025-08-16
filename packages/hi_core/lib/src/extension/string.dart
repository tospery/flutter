import 'dart:ui';
import 'package:flutter/material.dart';

extension StringHiCoreEx on String {
  // dynamic toJson() {
  //   return isNotEmpty ? convert.json.decode(this) : <String, dynamic>{};
  // }

  Color? toColor() {
    // // 去掉可能包含的#符号
    // hexColor = hexColor.replaceAll("#", "");
    // // 将字符串解析为整数，然后将其转换为Color对象
    // return Color(int.parse('0xff$hexColor'));

    final hexString = this.replaceAll("#", "");
    if (hexString.length == 6) {
      return Color(int.tryParse("0xFF$hexString") ?? 0);
    }
    return Color(int.tryParse("0x$hexString") ?? 0);

    // var hexString = toUpperCase().replaceAll('#', '');
    // if (hexString.length == 6) {
    //   hexString += 'FF';
    // }
    // var intValue = int.tryParse(hexString, radix: 16);
    // if (intValue == null) {
    //   return null;
    // }
    // return Color(intValue);

    // if (length < 7) {
    //   return null;
    // }
    // return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }

  Color get fixedColor => Color(_hexInt);

  int get _colorHash {
    int hash = 0;
    runes.forEach((code) {
      hash = code + ((hash << 5) - hash);
    });
    return hash;
  }

  int get _hexInt {
    String c = (_colorHash & 0x00FFFFFF).toRadixString(16).toUpperCase();
    String hex = "FF00000".substring(0, 8 - c.length) + c;
    return int.parse(hex, radix: 16);
  }
}
