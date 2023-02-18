import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/model/label.dart';
import 'package:hi_flutter/src/utils/text_linkifier.dart';
import 'package:hi_flutter/src/widget/cell.dart';

class HiLabelCell extends HiCell<HiLabel> {

  HiLabelCell({
    super.key,
    required super.model,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Linkify(
          textAlign: TextAlign.right,
          text: model.text ?? '',
          linkifiers: (model.links ?? []).map((e) => HiTextLinkifier(e)).toList(),
          style: context.textTheme.labelMedium,
          linkStyle: context.textTheme.titleSmall?.copyWith(
            color: context.theme.primaryColor,
          ),
          onOpen: (link) =>
          onPressed != null ? onPressed!(model, extra: link.url) : null,
        ),
      ),
    );
  }

}