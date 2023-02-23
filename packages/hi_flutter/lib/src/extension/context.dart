import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_flutter/src/core/function.dart' as hi_flutter;

extension BuildContextEx on BuildContext {
  double metricWidth(double width) => hi_flutter.metricWidth(width, context: this);
  double metricHeight(double height) => hi_flutter.metricHeight(height, context: this);

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

}
