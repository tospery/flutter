import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/input_cell.dart';

class HiInput extends HiModel {
  final bool? autofocus;
  final String? hint;
  final String? text;

  @override
  Widget? cell({
    HiCellPressed? onPressed,
    HiDynamicCallback? onChanged,
  }) => HiInputCell(model: this, onChanged: onChanged);

  const HiInput({
    this.autofocus,
    this.hint,
    this.text,
  });

  factory HiInput.fromJson(Map<String, dynamic> json) => HiInput(
        autofocus: json.boolForKey('autofocus'),
        hint: json.stringForKey('hint'),
        text: json.stringForKey('text'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'autofocus': autofocus,
        'hint': hint,
        'text': text,
      };

  HiInput copyWith({
    bool? autofocus,
    String? hint,
    String? text,
  }) {
    return HiInput(
      autofocus: autofocus ?? this.autofocus,
      hint: hint ?? this.hint,
      text: text ?? this.text,
    );
  }

  @override
  List<Object?> get props => [autofocus, hint, text];
}
