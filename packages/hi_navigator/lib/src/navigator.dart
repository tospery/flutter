import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hi_navigator/src/impl/alert_view.dart';
import 'package:hi_navigator/src/impl/toast_activity.dart';
import 'package:hi_navigator/src/router.dart';
import 'package:url_launcher/url_launcher.dart';

class HiNavigator {
  final String? baseWeb;

  final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  static HiNavigator? _instance;
  static HiNavigator shared() {
    _instance ??= HiNavigator._();
    return _instance!;
  }

  HiNavigator._({String? baseWeb}) : this.baseWeb = baseWeb;

  static Future<bool> ready({String? baseWeb}) async {
    _instance ??= HiNavigator._(baseWeb: baseWeb);
    return true;
  }

  // void init() async {
  // }

  // Future<T?>? forward<T>(
  //     String url, {
  //       dynamic context,
  //       bool rootNavigator = false,
  //     }) {
  //   return null;
  // }

  Future<T?>? forward<T>({
    String? url,
    String? host,
    String? path,
    Map<String, dynamic>? parameters,
    dynamic context,
    bool rootNavigator = false,
  }) async {
    var route = url?.toRoute(baseWeb: HiNavigator.shared().baseWeb);
    if (route?.isEmpty ?? true) {
      if (host?.isNotEmpty ?? false) {
        route = "/$host";
        if (path?.isNotEmpty ?? false) {
          route += "/$path";
        }
      }
    }
    log('导航->$route, 参数$parameters', tag: HiLogTag.navigator);
    try {
      // 网页
      if (route?.isValidHttpUrl ?? false) {
        var myParameters = parameters ?? <String, dynamic>{};
        myParameters[HiParameter.url] = route;
        return Get.toNamed('/${HiRouter.hosts.web}', arguments: myParameters);
      }
      // 打开第三方应用
      if (route?.isValidThirdUrl ?? false) {
        final thirdUrl = route?.toUri();
        if (thirdUrl == null) {
          return null;
        }
        final result = await launchUrl(thirdUrl);
        if (!result) {
          log('打开第三方失败', tag: HiLogTag.navigator);
        }
        if (T == bool) {
          return Future.value(result as T);
        }
        return null;
      }
      if (rootNavigator) {
        return Get.offAllNamed(route!, arguments: parameters);
      }
      return Get.toNamed(route!, arguments: parameters);
    } catch (e) {
      log("导航错误：$e");
      return null;
    }
    return null;
  }

  void back<T>({
    T? result,
  }) {
    Get.back(result: result);
  }

  toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
      msg: message,
    );
  }

  showToastActivity({String? title}) {
    dismiss();
    Get.dialog(
      HiToastActivity(title: title),
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: false,
    );
  }

  hideToastActivity() {
    dismiss();
  }

  dismiss() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  alert({
    String? title,
    String? content,
    String? backText,
    String? nextText,
    bool? backVisible,
    bool? nextVisible,
    VoidCallback? backTap,
    VoidCallback? nextTap,
    backKey = false,
  }) {
    dismiss();
    Get.dialog(
      HiAlertView(
        title: title ?? '',
        content: content ?? '',
        backText: backText ?? '',
        nextText: nextText ?? '',
        backVisible: backVisible ?? false,
        nextVisible: nextVisible ?? false,
        backTap: backTap,
        nextTap: nextTap,
      ),
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: backKey,
    );
  }

  Future<T?> popup<T>(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    dismiss();
    return Get.dialog<T>(
      widget,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      navigatorKey: navigatorKey,
      arguments: arguments,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      name: name,
      routeSettings: routeSettings,
    );
  }
}
