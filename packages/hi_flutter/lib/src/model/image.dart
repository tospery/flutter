import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/image_cell.dart';

enum HiImageStyle {
  basic,
  circular,
  overlays;

  factory HiImageStyle.fromValue(dynamic value) =>
      {
        0: HiImageStyle.basic,
        1: HiImageStyle.circular,
        2: HiImageStyle.overlays,
      }[tryInt(value) ?? 0] ??
          HiImageStyle.basic;
}

class HiImage extends HiModel {
  final HiImageStyle? style;
  final String? image;
  final double? height;

  @override
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) =>
      HiImageCell(model: this, onPressed: onPressed);

  const HiImage({
    super.id,
    this.style,
    this.image,
    this.height,
  });

  factory HiImage.fromJson(dynamic data) => HiImage(
    id: tryJSON(data)?.stringValue('id'),
    style: tryJSON(data)?.enumValue('style', fromValue: HiImageStyle.fromValue),
    height: tryJSON(data)?.doubleValue('height'),
    image: tryJSON(data)?.stringValue('image'),
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'style': style,
    'image': image,
    'height': height,
  };

  HiImage copyWith({
    String? id,
    HiImageStyle? style,
    String? image,
    double? height,
  }) {
    return HiImage(
      id: id ?? this.id,
      style: style ?? this.style,
      image: image ?? this.image,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => [id, style, image, height];
}
