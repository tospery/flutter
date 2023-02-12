import 'package:hi_core/hi_core.dart';
import 'base_controller.dart';
import '../core/datatype.dart';

class HiWebController extends HiBaseController {
  // var isLoading = true.obs;
  late String url;

  @override
  void onInit() {
    super.onInit();
    // var arguments = Get.arguments as Map<String, dynamic>? ?? {};
    // url.value = parameters.stringForKey(HiParameter.url) ?? '';
    url = parameters.stringForKey(HiParameter.url) ?? '';
  }

  void loadFinished() {
    requestMode.value = HiRequestMode.none;
    update();
  }
}