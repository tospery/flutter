import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/input_cell.dart';

enum HiInputStyle {
  textField,
  textView;

  factory HiInputStyle.fromValue(dynamic value) =>
      {
        0: HiInputStyle.textField,
        1: HiInputStyle.textView,
      }[convertInt(value) ?? 0] ??
          HiInputStyle.textField;

  int toInt() => {
    HiInputStyle.textField: 0,
    HiInputStyle.textView: 1,
  }.value<int>(this) ?? 0;
}

class HiInput extends HiModel {
  final HiInputStyle? style;
  final bool? autofocus;
  final String? hint;
  final String? text;
  
  Widget? cell({HiCellPressed? onPressed, HiValueChanged? onChanged}) => HiInputCell(model: this, onChanged: onChanged,);
  
  const HiInput({
    super.id,
    this.style,
    this.autofocus,
    this.hint,
    this.text,
  });

  factory HiInput.fromJson(dynamic data) => HiInput(
        id: convertJSON(data)?.value<String>('id'),
        style: convertJSON(data)?.value<HiInputStyle>('style', fromValue: HiInputStyle.fromValue),
        autofocus: convertJSON(data)?.value<bool>('autofocus'),
        hint: convertJSON(data)?.value<String>('hint'),
        text: convertJSON(data)?.value<String>('text'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'style': style,
        'autofocus': autofocus,
        'hint': hint,
        'text': text,
      };

  HiInput copyWith({
    String? id,
    HiInputStyle? style,
    bool? autofocus,
    String? hint,
    String? text,
  }) {
    return HiInput(
      id: id ?? this.id,
      style: style ?? this.style,
      autofocus: autofocus ?? this.autofocus,
      hint: hint ?? this.hint,
      text: text ?? this.text,
    );
  }

  @override
  List<Object?> get props => [id, style, autofocus, hint, text];
}
