import 'package:hi_core/hi_core.dart';
import 'base_controller.dart';
import '../core/datatype.dart';

class HiWebController extends HiBaseController {
  late final String url;

  @override
  void onInit() {
    super.onInit();
    url = parameters.stringForKey(R.parameters.url) ?? '';
    log('url: $url', tag: HiLogTag.frame);
  }

  void loadFinished() {
    requestMode.value = HiRequestMode.none;
    update();
  }
}