import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/button_cell.dart';

enum HiButtonStyle {
  fullWidth,
  rounded;

  factory HiButtonStyle.fromValue(dynamic value) =>
      {
        0: HiButtonStyle.fullWidth,
        1: HiButtonStyle.rounded,
      }[tryInt(value) ?? 0] ??
          HiButtonStyle.fullWidth;
}

class HiButton extends HiModel {
  final HiButtonStyle? style;
  final String? icon;
  final String? title;
  final double? height;
  final String? titleColor;
  final String? backgroundColor;
  
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => HiButtonCell(model: this, onPressed: onPressed,);
  
  const HiButton({
    super.id,
    this.icon,
    this.style,
    this.title,
    this.height,
    this.titleColor,
    this.backgroundColor,
  });

  factory HiButton.fromJson(dynamic data) => HiButton(
        id: tryJSON(data)?.stringValue('id'),
        style: tryJSON(data)?.enumValue('style', fromValue: HiButtonStyle.fromValue),
        height: tryJSON(data)?.doubleValue('height'),
        title: tryJSON(data)?.stringValue('title'),
        icon: tryJSON(data)?.stringValue('icon'),
        titleColor: tryJSON(data)?.stringValue('titleColor'),
        backgroundColor: tryJSON(data)?.stringValue('backgroundColor'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'style': style,
        'title': title,
        'icon': icon,
        'height': height,
        'titleColor': titleColor,
        'backgroundColor': backgroundColor,
      };

  HiButton copyWith({
    String? id,
    HiButtonStyle? style,
    String? title,
    String? icon,
    double? height,
    String? titleColor,
    String? backgroundColor,
  }) {
    return HiButton(
      id: id ?? this.id,
      style: style ?? this.style,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      height: height ?? this.height,
      titleColor: titleColor ?? this.titleColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  List<Object?> get props =>
      [id, style, title, icon, height, titleColor, backgroundColor];
}
