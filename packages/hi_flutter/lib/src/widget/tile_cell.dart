import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/extension/context.dart';
import 'package:hi_flutter/src/extension/theme.dart';
import 'package:hi_flutter/src/model/tile.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_flutter/src/widget/cell.dart';

class HiTileCell extends HiCell<HiTile> {
  const HiTileCell({
    super.key,
    required super.model,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      radius: 0,
      title: isNotEmpty(model.title) ? Text(model.title!, style: context.textTheme.titleSmall,) : Container(),
      subTitleText: model.subTitle,
      avatar: model.icon?.isNotEmpty ?? false
          ? hiImage(model.icon!, height: 24, context: context)
          : null,
      icon: _buildTileDetail(context),
      color: context.theme.bgColor,
      onTap: () => onPressed != null ? onPressed!(model) : null,
      shadow: BoxShadow(),
    );
  }

  _buildTileDetail(BuildContext context) {
    var children = <Widget>[];
    if (model.detail?.isNotEmpty ?? false) {
      children.add(
        Text(
          model.detail!,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.unselectedWidgetColor,
          ),
        ),
      );
    }
    if (model.indicated ?? false) {
      children.add(Icon(
        Icons.keyboard_arrow_right,
        color: context.theme.indicatorColor,
      ));
    }
    return Row(
      children: children,
    );
  }
}