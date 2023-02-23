import 'package:hi_core/hi_core.dart';
import 'package:get/get.dart';
import 'base_controller.dart';
import '../core/datatype.dart';

class HiWebController extends HiBaseController {
  var progress = 0.0.obs;
  late final String url;

  @override
  void onInit() {
    super.onInit();
    url = parameters.stringForKey(R.parameters.url) ?? '';
    log('url: $url', tag: HiLogTag.frame);
  }

  void doPageStarted() {
    requestMode.value = HiRequestMode.load;
    update();
  }

  void doProgress(int value) {
    progress.value = (value / 100.0).toDouble();
    update();
  }

  void doPageFinished(String? title) {
    if (this.title.value == null) {
      this.title.value = title;
    }
    requestMode.value = HiRequestMode.none;
    update();
  }
}