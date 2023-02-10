import 'package:get/get.dart';

dismissDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}