import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hi_navigator/src/impl/alert_view.dart';
import 'package:hi_navigator/src/impl/toast_activity.dart';
import 'package:hi_navigator/src/router.dart';
import 'package:url_launcher/url_launcher.dart';

class HiNavigator {

  final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

  static HiNavigator? _instance;
  static HiNavigator shared() {
    _instance ??= HiNavigator._();
    return _instance!;
  }

  HiNavigator._() {
    init();
  }

  void init() async {
  }

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
    var route = url;
    if (route == null) {
      if (host?.isNotEmpty ?? false) {
        route = "/$host";
        if (path?.isNotEmpty ?? false) {
          route += "/$path";
        }
      }
    } else {
      route = route?.toRoute();
    }
    if (route?.isEmpty ?? true) {
      return null;
    }
    log('导航->$route, 参数$parameters', tag: HiLogTag.navigator);
    // 打开第三方应用
    if (route?.isValidThirdUrl ?? false) {
      final thirdUrl = route?.toUri();
      if (thirdUrl == null) {
        return null;
      }
      final result = await launchUrl(thirdUrl);
      if (!result)  {
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
    try {
      return Get.toNamed(route!, arguments: parameters);
    } catch (e) {
      // if ((url?.isNotEmpty ?? false) && ((url?.startsWith('http://') ?? false) || (url?.startsWith('https://') ?? false))) {
      if (url?.isNotEmpty ?? false) {
        var myParameters = parameters ?? <String, dynamic>{};
        myParameters[HiParameter.url] = url;
        return Get.toNamed('/${HiRouter.hosts.web}', arguments: myParameters);
      }
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
        backText : backText ?? '',
        nextText : nextText ?? '',
        backVisible : backVisible ?? false,
        nextVisible : nextVisible ?? false,
        backTap : backTap,
        nextTap : nextTap,
      ),
      transitionDuration:  const Duration(milliseconds: 500),
      barrierDismissible: backKey,
    );
  }

}