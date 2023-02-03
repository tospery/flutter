import 'package:get/get.dart';
import 'package:hi_flutter/src/web/web_controller.dart';

class HiWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HiWebController>(() => HiWebController());
  }
}
