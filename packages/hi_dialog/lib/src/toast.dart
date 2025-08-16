import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hi_dialog/src/impl/toast_activity.dart';

toast(String message) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: message,
  );
}

showToastActivity({String? title}) {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Get.dialog(
    HiToastActivity(title: title),
    transitionDuration: const Duration(milliseconds: 500),
    barrierDismissible: false,
  );
}
