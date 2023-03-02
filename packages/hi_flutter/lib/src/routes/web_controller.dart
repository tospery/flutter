import 'package:hi_core/hi_core.dart';
import 'package:get/get.dart';
import 'base_controller.dart';
import '../core/datatype.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiWebController extends HiBaseController {
  late final WebViewController webViewController;
  var progress = 0.0.obs;
  late final String url;

  @override
  void onInit() {
    super.onInit();
    url = parameters.stringForKey(R.parameters.url) ?? '';
    log('url: $url', tag: HiLogTag.frame);
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: doProgress,
          onPageStarted: doPageStarted,
          onPageFinished: doPageFinished,
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: doNavigationRequest,
        ),
      );
    var uri = Uri.tryParse(url);
    if (uri != null) {
      webViewController.loadRequest(uri);
    }
  }

  void doPageStarted(String url) {
    requestMode.value = HiRequestMode.load;
    update();
  }

  void doProgress(int value) {
    progress.value = (value / 100.0).toDouble();
    update();
  }

  void doPageFinished(String url) async {
    if (this.title.value == null) {
      this.title.value = await webViewController?.getTitle();
    }
    requestMode.value = HiRequestMode.none;
    update();
  }

  NavigationDecision doNavigationRequest(NavigationRequest navigation) {
    return NavigationDecision.navigate;
  }

}