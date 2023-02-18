import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/label_cell.dart';

class HiLabel extends HiModel {
  final String? text;
  final List<String>? links;

  @override
  Widget? cell({
    HiCellPressed? onPressed,
    HiDynamicCallback? onChanged,
  }) => HiLabelCell(model: this, onPressed: onPressed);

  const HiLabel({
    this.text,
    this.links,
  });

  factory HiLabel.fromJson(Map<String, dynamic> json) => HiLabel(
        text: json.stringForKey('text'),
        links: json.listForKey<String>('links'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'text': text,
        'links': links,
      };

  HiLabel copyWith({
    String? text,
    List<String>? links,
  }) {
    return HiLabel(
      text: text ?? this.text ?? '',
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [text, links];
}
