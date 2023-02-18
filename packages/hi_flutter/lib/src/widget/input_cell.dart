import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/hi_flutter.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_flutter/src/extension/context.dart';
import 'package:hi_flutter/src/model/input.dart';
import 'package:hi_flutter/src/widget/cell.dart';

class TextFieldCell extends HiCell<HiInput> {
  final HiCallback? onChanged;

  const TextFieldCell({
    super.key,
    required super.model,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: context.theme.bgColor,
        border: hiOutlineBorder(width: 0, radius: 0, context: context),
        enabledBorder: hiOutlineBorder(width: 0, radius: 0, context: context),
        focusedBorder: hiOutlineBorder(width: 0, radius: 0, context: context),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        hintText: model.hint,
      ),
      autofocus: model.autofocus ?? false,
      controller: TextEditingController(text: model.text),
      onChanged: (value) => onChanged != null ? onChanged!(value) : null,
    );
  }
}
