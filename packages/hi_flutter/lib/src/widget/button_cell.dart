import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_flutter/src/model/button.dart';
import 'package:hi_flutter/src/widget/cell.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hi_core/hi_core.dart';

class HiButtonCell extends HiCell<HiButton> {

  const HiButtonCell({
    super.key,
    required super.model,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final style = model.style ?? HiButtonStyle.fullWidth;
    if (style == HiButtonStyle.rounded) {
      return _buildRoundedButton(context);
    }
    return _buildFullWidthButton(context);
  }

  Widget _buildFullWidthButton(BuildContext context) {
    return GFButton(
      onPressed: () => onPressed != null ? onPressed!(model) : null,
      text: model.title,
      size: model.height ?? (context.width * HiConstant.heightRatioMedium),
      borderShape: hiBorder(width: 0),
      borderSide: BorderSide.none,
      color: model.backgroundColor?.toColor() ?? context.theme.cardColor,
      textStyle: context.textTheme.titleMedium?.copyWith(
          color: context.theme.primaryColor
      ),
    );
  }

  Widget _buildRoundedButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: GFButton(
        text: model.title,
        size: model.height ?? (context.width * HiConstant.heightRatioMedium),
        color: model.titleColor?.toColor() ?? context.theme.primaryColor,
        borderShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        fullWidthButton: true,
        disabledTextColor: context.theme.cardColor,
        onPressed: onPressed != null ? () => onPressed!(model) : null,
      ),
    );
  }

}