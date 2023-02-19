import 'package:flutter/material.dart';
import 'model.dart';
import 'package:hi_core/src/datatype.dart';
import 'package:hi_core/src/logger.dart';

class HiWrap extends HiModel {
  final dynamic value;

  const HiWrap({
    super.id,
    this.value,
  });
}