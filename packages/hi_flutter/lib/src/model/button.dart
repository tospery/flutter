import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/button_cell.dart';

class HiButton extends HiModel {
  final int? style;
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

  factory HiButton.fromJson(Map<String, dynamic> json) => HiButton(
        id: json.value<String>('id'),
        style: json.value<int>('style'),
        height: json.value<double>('height'),
        title: json.value<String>('title'),
        icon: json.value<String>('icon'),
        titleColor: json.value<String>('titleColor'),
        backgroundColor: json.value<String>('backgroundColor'),
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
    int? style,
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
