import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/space_cell.dart';

class HiSpace extends HiModel {
  final int? style;
  final String? color;
  final double? height;
  
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => HiSpaceCell(model: this);
  
  const HiSpace({
    this.style,
    this.color,
    this.height,
  });

  factory HiSpace.fromJson(dynamic data) => HiSpace(
        style: convert2JSON(data)?.value<int>('style'),
        color: convert2JSON(data)?.value<String>('color'),
        height: convert2JSON(data)?.value<double>('height'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'style': style,
        'color': color,
        'height': height,
      };

  HiSpace copyWith({
    int? style,
    String? color,
    double? height,
  }) {
    return HiSpace(
      style: style ?? this.style,
      color: color ?? this.color,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => [style, color, height];
}
