import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/label_cell.dart';

class HiLabel extends HiModel {
  final String? text;
  final List<String>? links;
  
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => HiLabelCell(model: this, onPressed: onPressed,);
  
  const HiLabel({
    super.id,
    this.text,
    this.links,
  });

  factory HiLabel.fromJson(Map<String, dynamic> json) => HiLabel(
        id: json.stringForKey('id'),
        text: json.stringForKey('text'),
        links: json.listForKey<String>('links'),
      );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
        'text': text,
        'links': links,
      };

  HiLabel copyWith({
    String? id,
    String? text,
    List<String>? links,
  }) {
    return HiLabel(
      id: id ?? this.id,
      text: text ?? this.text,
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [id, text, links];
}
