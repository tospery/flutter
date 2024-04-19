import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hi_core/hi_core.dart';
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
    final tile = GFListTile(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(left: 12, top: 10, right: 0, bottom: 10),
      radius: 0,
      title: _buildTileTitle(context),
      subTitle: _buildTileSubtitle(context),
      avatar: model.icon?.isNotEmpty ?? false
          ? newImageWidget(model.icon!, height: 24, context: context)
          : null,
      icon: _buildTileDetail(context),
      color: context.theme.bgColor,
      onTap: () => onPressed != null ? onPressed!(model) : null,
      shadow: BoxShadow(),
    );
    return ((model.height ?? 0) == 0) ? tile :
     Container(
      height: model.height,
      child: tile,
    );
  }

  _buildTileTitle(BuildContext context) {
    if (model.title?.isEmpty ?? true) {
      return Container();
    }
    return Text(model.title!, style: context.textTheme.titleMedium?.copyWith(
      color: model.titleColor?.toColor(),
    ), maxLines: 1, overflow: TextOverflow.ellipsis,);
  }

  _buildTileSubtitle(BuildContext context) {
    if (model.subTitle?.isEmpty ?? true) {
      return Container();
    }
    return Text(model.subTitle!, style: context.textTheme.titleSmall,);
  }

  _buildTileDetail(BuildContext context) {
    var children = <Widget>[];
    if (model.checked != null) {
      if (model.checked ?? false) {
        children.addAll([
          Icon(
            Icons.check,
            size: 24,
            color: context.theme.primaryColor,
          ),
          newBox(width: 20),
        ]);
      }
    } else {
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
      if (model.indicated ?? true) {
        children.add(Icon(
          Icons.keyboard_arrow_right,
          color: context.theme.indicatorColor,
        ));
        children.add(newBox(width: 8));
      }
    }
    return Row(
      children: children,
    );
  }
}