import 'package:flutter/material.dart';
import 'package:hi_base/src/model/model.dart';

typedef HiValueChanged = void Function(dynamic value);
typedef HiCellPressed<M extends HiModel> =
    void Function(M model, {dynamic extra});
typedef HiDynamicCallback = dynamic Function(dynamic value);
typedef HiBuildWidget = Widget Function(BuildContext context);
