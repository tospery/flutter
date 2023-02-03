import 'package:get/get.dart';
import '../view/hi_loading_dialog.dart';

extension GetEx on GetInterface {
  void loading({String? title}) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    Get.dialog(
      HiLoadingDialog(title: title),
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: false,
    );
  }

  void dismiss() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  // Future<bool?> toast(String message) {
  //   dismiss();
  //   return Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.CENTER,
  //   );
  // }
}
