import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hi_navigator/src/impl/alert_view.dart';
import 'package:hi_navigator/src/impl/toast_activity.dart';

class HiNavigator {

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

  Future<T?>? forward<T>(
      String url, {
        dynamic context,
        bool rootNavigator = false,
      }) {
    return null;
  }

  void back<T>({
    T? result,
  }) {}

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