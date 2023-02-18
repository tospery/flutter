import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/text_cell.dart';

class HiText extends HiModel {
  final String content;
  final List<String>? links;

  @override
  Widget? cell({
    HiCellPressed? onPressed,
    HiDynamicCallback? onChanged,
  }) => HiTextCell(model: this, onPressed: onPressed);

  const HiText(
    this.content, {
    this.links,
  });

  factory HiText.fromJson(Map<String, dynamic> json) => HiText(
        json.stringForKey('content') ?? '',
        links: json.listForKey<String>('links'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'content': content,
        'links': links,
      };

  HiText copyWith({
    String? content,
    List<String>? links,
  }) {
    return HiText(
      content ?? this.content ?? '',
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [content, links];
}
