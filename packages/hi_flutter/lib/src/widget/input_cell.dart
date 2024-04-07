import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/hi_flutter.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_flutter/src/extension/context.dart';
import 'package:hi_flutter/src/model/input.dart';
import 'package:hi_flutter/src/widget/cell.dart';

class HiInputCell extends HiCell<HiInput> {
  final HiValueChanged? onChanged;

  const HiInputCell({
    super.key,
    required super.model,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final style = model.style ?? HiInputStyle.textField;
    if (style == HiInputStyle.textView) {
      return _buildTextView(context);
    }
    return _buildTextField(context);
  }

  Widget _buildTextField(BuildContext context) {
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

  Widget _buildTextView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: context.theme.cardColor,
          contentPadding: EdgeInsets.all(10),
          border: hiOutlineBorder(width: 0, radius: 0, context: context),
          enabledBorder: hiOutlineBorder(width: 0, radius: 0, context: context),
          focusedBorder: hiOutlineBorder(width: 0, radius: 0, context: context),
          disabledBorder: hiOutlineBorder(width: 0, radius: 0, context: context),
          errorBorder: hiOutlineBorder(width: 0, radius: 0, context: context),
          focusedErrorBorder: hiOutlineBorder(width: 0, radius: 0, context: context),
        ),
        maxLines: 7,
        minLines: 5,
        maxLength: 160,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        controller: TextEditingController(text: model.text),
        onChanged: (value) => onChanged != null ? onChanged!(value) : null,
      ),
    );
  }

}
