import 'package:flutter/material.dart';
import 'package:hi_flutter/src/model/space.dart';
import 'package:hi_flutter/src/widget/cell.dart';
import 'package:hi_core/hi_core.dart';

class HiSpaceCell extends HiCell<HiSpace> {
  const HiSpaceCell({
    super.key,
    required super.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: model.height ?? HiConstant.spaceHeightMedium,
      color: model.color?.toColor() ?? Colors.transparent,
    );
  }
}