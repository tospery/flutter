import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/input_cell.dart';

class HiInput extends HiModel {
  final bool? autofocus;
  final String? hint;
  final String? text;
  
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => HiInputCell(model: this, onChanged: onChanged,);
  
  const HiInput({
    super.id,
    this.autofocus,
    this.hint,
    this.text,
  });

  factory HiInput.fromJson(Map<String, dynamic> json) => HiInput(
        id: json.stringForKey('id'),
        autofocus: json.boolForKey('autofocus'),
        hint: json.stringForKey('hint'),
        text: json.stringForKey('text'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'autofocus': autofocus,
        'hint': hint,
        'text': text,
      };

  HiInput copyWith({
    String? id,
    bool? autofocus,
    String? hint,
    String? text,
  }) {
    return HiInput(
      id: id ?? this.id,
      autofocus: autofocus ?? this.autofocus,
      hint: hint ?? this.hint,
      text: text ?? this.text,
    );
  }

  @override
  List<Object?> get props => [id, autofocus, hint, text];
}
