import 'package:flutter/material.dart';
import 'model.dart';
import 'package:hi_core/src/datatype.dart';
import 'package:hi_core/src/logger.dart';

class HiWrap extends HiModel {
  final dynamic value;

  Widget? cell({
    HiCellPressed? onPressed,
    HiDynamicCallback? onChanged,
  }) => Container();

  const HiWrap({
    super.id,
    this.value,
  });
}