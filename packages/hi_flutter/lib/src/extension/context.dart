import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_flutter/src/core/function.dart' as hi_flutter;

extension BuildContextEx on BuildContext {
  // MediaQueryData get mediaQueryData => MediaQuery.of(this);
  // Size get mediaQueryDataSize => mediaQueryData.size;

  // AssetBundle get assetBundle => DefaultAssetBundle.of(this);

  // ThemeData get themeData => Theme.of(this);
  // TargetPlatform get themeDataPlatform => Theme.of(this).platform;

  // ModalRoute<Object?>? get modalRoute => ModalRoute.of(this);
  // RouteSettings? get modalRouteSettings => modalRoute?.settings;
  // Object? get modalRouteSettingsArguments => modalRouteSettings?.arguments;
  
  // ColorScheme get colorScheme => theme.colorScheme;
  // TextTheme get primaryTextTheme => theme.primaryTextTheme;

  double metricWidth(double width) => hi_flutter.metricWidth(width, context: this);
  double metricHeight(double height) => hi_flutter.metricHeight(height, context: this);

  // TextStyle tsBg(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.bgColor);
  // TextStyle ts50(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.canvasColor);
  // TextStyle ts100(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.cardColor);
  // TextStyle ts200(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.hoverColor);
  // TextStyle ts300(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.splashColor);
  // TextStyle ts350(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.highlightColor);
  // TextStyle ts400(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.dividerColor);
  // TextStyle tsGrey(double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: Colors.grey);
  // TextStyle ts600(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.indicatorColor);
  // TextStyle ts700(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.focusColor);
  // TextStyle ts800(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.hintColor);
  // TextStyle ts850(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.disabledColor);
  // TextStyle ts900(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.shadowColor);
  // TextStyle tsFg(BuildContext context, double fontSize) =>
  //     TextStyle(fontSize: fontSize, color: context.theme.fgColor);
}
