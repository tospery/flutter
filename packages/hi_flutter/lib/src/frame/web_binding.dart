import 'package:get/get.dart';
import 'web_controller.dart';

class HiWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HiWebController>(() => HiWebController());
  }
}
