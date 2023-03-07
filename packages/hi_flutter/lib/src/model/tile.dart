import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/tile_cell.dart';

class HiTile extends HiModel {
  final int? style;
  final String? title;
  final String? subTitle;
  final String? detail;
  final String? icon;
  final String? color;
  final double? height;
  final bool? indicated;
  final bool? separated;

  Widget? get separator => separated ?? false ? const Divider() : null;
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => HiTileCell(model: this, onPressed: onPressed,);

  const HiTile({
    super.id,
    this.style,
    this.title,
    this.subTitle,
    this.detail,
    this.icon,
    this.color,
    this.height,
    this.indicated = true,
    this.separated = true,
  });

  factory HiTile.fromJson(Map<String, dynamic> json) => HiTile(
        id: json.value<String>('id'),
        style: json.value<int>('style'),
        title: json.value<String>('title'),
        subTitle: json.value<String>('subTitle'),
        detail: json.value<String>('detail'),
        icon: json.value<String>('icon'),
        color: json.value<String>('color'),
        height: json.value<double>('height'),
        indicated: json.value<bool>('indicated'),
        separated: json.value<bool>('separated'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'style': style,
        'title': title,
        'subTitle': subTitle,
        'detail': detail,
        'icon': icon,
        'color': color,
        'height': height,
        'indicated': indicated,
        'separated': separated,
      };

  HiTile copyWith({
    String? id,
    int? style,
    String? title,
    String? subTitle,
    String? detail,
    String? icon,
    String? color,
    double? height,
    bool? indicated,
    bool? separated,
  }) {
    return HiTile(
      id: id ?? this.id,
      style: style ?? this.style,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      detail: detail ?? this.detail,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      height: height ?? this.height,
      indicated: indicated ?? this.indicated,
      separated: separated ?? this.separated,
    );
  }

  @override
  List<Object?> get props => [
        id,
        style,
        icon,
        title,
        subTitle,
        detail,
        color,
        height,
        indicated,
        separated,
      ];
}
