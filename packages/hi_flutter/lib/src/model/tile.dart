import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/tile_cell.dart';

class HiTile extends HiModel {
  final String? title;
  final String? subTitle;
  final String? detail;
  final String? icon;
  final String? titleColor;
  final String? backgroundColor;
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
    this.titleColor,
    this.backgroundColor,
    this.height,
    this.checked,
    this.indicated,
    this.separated,
  });

  factory HiTile.fromJson(dynamic data) => HiTile(
        id: tryJSON(data)?.stringValue('id'),
        title: tryJSON(data)?.stringValue('title'),
        subTitle: tryJSON(data)?.stringValue('subTitle'),
        detail: tryJSON(data)?.stringValue('detail'),
        icon: tryJSON(data)?.stringValue('icon'),
        titleColor: tryJSON(data)?.stringValue('titleColor'),
        backgroundColor: tryJSON(data)?.stringValue('backgroundColor'),
        height: tryJSON(data)?.doubleValue('height'),
        checked: tryJSON(data)?.boolValue('checked'),
        indicated: tryJSON(data)?.boolValue('indicated'),
        separated: tryJSON(data)?.boolValue('separated'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subTitle': subTitle,
        'detail': detail,
        'icon': icon,
        'titleColor': titleColor,
        'backgroundColor': backgroundColor,
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
    String? titleColor,
    String? backgroundColor,
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
      titleColor: titleColor ?? this.titleColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
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
        titleColor,
        backgroundColor,
        height,
        checked,
        indicated,
        separated,
      ];
}
