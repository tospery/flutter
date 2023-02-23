import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hi_navigator/src/impl/alert_view.dart';
import 'package:hi_navigator/src/impl/toast_activity.dart';

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
    var urlString = url;
    if (urlString == null) {
      if (host?.isNotEmpty ?? false) {
        if (path?.isNotEmpty ?? false) {
          urlString = '/$host/$path';
        } else {
          urlString = '/$host';
        }
      }
    } else {
      urlString = Uri.tryParse(urlString!)?.route;
    }
    if (urlString?.isEmpty ?? true) {
      return null;
    }
    log('导航->$urlString, 参数$parameters', tag: HiLogTag.navigator);
    if (rootNavigator) {
      return Get.offAllNamed(urlString!, arguments: parameters);
    }
    try {
      return Get.toNamed(urlString!, arguments: parameters);
    } catch (e) {
      log('导航异常：$e', tag: HiLogTag.navigator);
      // if ((url?.isNotEmpty ?? false) && ((url?.startsWith('http://') ?? false) || (url?.startsWith('https://') ?? false))) {
      if (url?.isNotEmpty ?? false) {
        var myParameters = parameters ?? <String, dynamic>{};
        myParameters['url'] = url;
        return Get.toNamed('/web', arguments: myParameters);
      }
      return null;
    }
    log('看看结果');
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