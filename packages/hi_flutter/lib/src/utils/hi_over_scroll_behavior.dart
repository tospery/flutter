import 'package:flutter/material.dart';

class HiOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    var platform = getPlatform(context);
    if (platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia) {
      return GlowingOverscrollIndicator(
        showLeading: false,
        showTrailing: false,
        axisDirection: details.direction,
        color: Colors.red,
        child: child,
      );
    }
    // return child;
    return super.buildOverscrollIndicator(context, child, details);
  }
}
