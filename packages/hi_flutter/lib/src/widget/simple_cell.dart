import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/extension/build_context.dart';
import 'package:hi_flutter/src/model/simple.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_flutter/src/widget/cell.dart';

class HiSimpleCell extends HiCell<HiSimple> {
  const HiSimpleCell({
    super.key,
    required super.model,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (model.isSpace) {
      return _buildSpace(context);
    }
    if (model.isButton) {
      return _buildButton(context);
    }
    return GFListTile(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      // titleText: model.title,
      title: isNotEmpty(model.title) ? Text(model.title!, style: context.textTheme.titleSmall,) : Container(),
      subTitleText: model.subTitle,
      avatar: model.icon?.isNotEmpty ?? false
          ? hiImage(model.icon!, height: 24)
          : null,
      icon: _buildTileDetail(context),
      color: context.theme.cardColor, // context.colorScheme.onBackground,
      onTap: () => onPressed != null ? onPressed!(model) : null,
    );
  }

  Widget _buildSpace(BuildContext context) {
    return Container(
      height: model.height ?? 15,
      color: model.color?.toColor() ?? Colors.transparent,
    );
  }

  Widget _buildButton(BuildContext context) {
    // return GestureDetector(
    //   onTap: () => onPressed != null ? onPressed!(model) : null,
    //   child: Container(
    //     height: model.height ?? 50,
    //     color: model.color?.toColor() ?? context.colorScheme.onBackground,
    //     child: Center(
    //         child: model.title != null
    //             ? Text(
    //           model.title!,
    //           style: context.textTheme.titleMedium
    //               ?.copyWith(color: context.colorScheme.secondary),
    //         )
    //             : null),
    //     // color: Colors.red,
    //   ),
    // );
    return GFButton(
      onPressed: () => onPressed != null ? onPressed!(model) : null,
      text: model.title,
      size: model.height ?? R.constants.metric.cellHeightMedium,
      borderShape: hiBorder(width: 0),
      borderSide: BorderSide.none,
      color: model.color?.toColor() ?? context.theme.cardColor,
      // textColor: context.theme.primaryColor,
      textStyle: context.textTheme.titleMedium?.copyWith(
        color: context.theme.primaryColor
      ),
    );
  }

  _buildTileDetail(BuildContext context) {
    var children = <Widget>[];
    if (model.detail?.isNotEmpty ?? false) {
      children.add(
        Text(
          model.detail!,
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.normal),
        ),
      );
    }
    if (model.hasIndicator) {
      children.add(const Icon(Icons.keyboard_arrow_right));
    }
    return Row(
      children: children,
    );
  }
}