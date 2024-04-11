import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_flutter/src/model/image.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_flutter/src/extension/context.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/widget/cell.dart';

class HiImageCell extends HiCell<HiImage> {
  const HiImageCell({
    super.key,
    required super.model,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var top = Get.context?.safeArea.top ?? 0;
    var bottom = Get.context?.safeArea.bottom ?? 0;
    return SizedBox(
      width: context.width,
      height: model.height ?? context.height - top - kToolbarHeight - bottom,
      child: Center(
        child: newImageWidget(model.image!),
      ),
    );
  }
}
