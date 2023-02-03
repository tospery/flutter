import 'package:flutter/services.dart';

class HiFilterTextInputFormatter extends TextInputFormatter {
  final Pattern filterPattern;

  HiFilterTextInputFormatter(this.filterPattern);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.isComposingRangeValid) return newValue;
    return FilteringTextInputFormatter.allow(filterPattern)
        .formatEditUpdate(oldValue, newValue);
  }
}
