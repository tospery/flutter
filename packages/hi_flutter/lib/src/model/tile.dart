import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/tile_cell.dart';

class HiTile extends HiModel {
  final String? title;
  final String? subTitle;
  final String? detail;
  final String? icon;
  final String? color;
  final double? height;
  final bool? checked;
  final bool? indicated;
  final bool? separated;

  Widget? get separator => separated ?? true ? const Divider() : null;
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => HiTileCell(model: this, onPressed: onPressed,);

  const HiTile({
    super.id,
    this.title,
    this.subTitle,
    this.detail,
    this.icon,
    this.color,
    this.height,
    this.checked,
    this.indicated,
    this.separated,
  });

  factory HiTile.fromJson(Map<String, dynamic> data) => HiTile(
        id: tryJSON(data)?.value<String>('id'),
        title: tryJSON(data)?.value<String>('title'),
        subTitle: tryJSON(data)?.value<String>('subTitle'),
        detail: tryJSON(data)?.value<String>('detail'),
        icon: tryJSON(data)?.value<String>('icon'),
        color: tryJSON(data)?.value<String>('color'),
        height: tryJSON(data)?.value<double>('height'),
        checked: tryJSON(data)?.value<bool>('checked'),
        indicated: tryJSON(data)?.value<bool>('indicated'),
        separated: tryJSON(data)?.value<bool>('separated'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subTitle': subTitle,
        'detail': detail,
        'icon': icon,
        'color': color,
        'height': height,
        'checked': checked,
        'indicated': indicated,
        'separated': separated,
      };

  HiTile copyWith({
    String? id,
    String? title,
    String? subTitle,
    String? detail,
    String? icon,
    String? color,
    double? height,
    bool? checked,
    bool? indicated,
  }) {
    return HiTile(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      detail: detail ?? this.detail,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      height: height ?? this.height,
      checked: checked ?? this.checked,
      indicated: indicated ?? this.indicated,
    );
  }

  @override
  List<Object?> get props => [
        id,
        icon,
        title,
        subTitle,
        detail,
        color,
        height,
        checked,
        indicated,
        separated,
      ];
}
