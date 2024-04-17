import 'package:flutter/material.dart';
import 'package:get/get.dart';

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