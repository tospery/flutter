import 'package:flutter/material.dart';
import 'package:hi_flutter/src/core/function.dart' as hi_flutter;

extension BuildContextHiFlutterEx on BuildContext {
  EdgeInsets get safeArea => MediaQuery.of(this).padding;
  double metricWidth(double width) => hi_flutter.metricWidth(width, context: this);
  double metricHeight(double height) => hi_flutter.metricHeight(height, context: this);
}
