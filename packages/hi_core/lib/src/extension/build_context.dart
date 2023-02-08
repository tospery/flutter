import 'package:flutter/material.dart';

extension BuildContextEx on BuildContext {
  // MediaQueryData get mediaQueryData => MediaQuery.of(this);
  // Size get mediaQueryDataSize => mediaQueryData.size;

  // AssetBundle get assetBundle => DefaultAssetBundle.of(this);

  // ThemeData get themeData => Theme.of(this);
  // TargetPlatform get themeDataPlatform => Theme.of(this).platform;

  // ModalRoute<Object?>? get modalRoute => ModalRoute.of(this);
  // RouteSettings? get modalRouteSettings => modalRoute?.settings;
  // Object? get modalRouteSettingsArguments => modalRouteSettings?.arguments;

  ThemeData get themeData => Theme.of(this);
  ColorScheme get colorScheme => themeData.colorScheme;
  TextTheme get primaryTextTheme => themeData.primaryTextTheme;
}
