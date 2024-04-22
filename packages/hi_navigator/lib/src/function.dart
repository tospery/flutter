import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_navigator/src/navigator.dart';

Map<String, dynamic> routeParameters(
    Map<String, dynamic> parameters, dynamic context) {
  var myParameters = <String, dynamic>{};
  myParameters.addAll(parameters);
  if (context != null) {
    if (context is Map<String, dynamic>) {
      myParameters.addAll(context);
    } else {
      myParameters[HiParameter.context] = context;
    }
  }
  return myParameters;
}

GetMaterialApp? routeApp({BuildContext? context, bool? isOverlay}) {
  var ctx = context;
  if (ctx == null) {
    if (isOverlay == true) {
      ctx = Get.overlayContext ?? Get.context;
    } else {
      ctx = Get.context ?? Get.overlayContext;
    }
  }
  return ctx?.findAncestorWidgetOfExactType<GetMaterialApp>();
}

Widget? routeWidget(String url, {BuildContext? context, bool? isOverlay}) {
  final app = routeApp(context: context, isOverlay: isOverlay);
  if (app == null) {
    return null;
  }
  final page = app.getPages?.firstWhereOrNull((e) => e.name == url);
  if (page == null) {
    return null;
  }
  return page.page();
}

String routeString(String host,
        {String? path, Map<String, dynamic>? parameters}) =>
    Uri(host: host, path: path, queryParameters: parameters)
        .toString()
        .toRoute(baseWeb: HiNavigator.shared().baseWeb);
