import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_controller.dart';
import 'base_page.dart';
import '../core/datatype.dart';

class HiWebPage<WC extends HiWebController> extends HiBasePage<WC> {
  WebViewController? _webViewController;
  final FocusNode _focusNode = FocusNode();

  HiWebPage({super.key});

  @override
  void initState() {
    super.initState();
    // if (GetPlatform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
  }

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        _buildFocus(context),
        _buildWebView(context),
        _buildLoadingView(context),
      ],
    );
  }

  _buildFocus(BuildContext context) {
    return TextField(focusNode: _focusNode);
  }

  _buildWebView(BuildContext context) {
    return WebViewWidget(controller: controller.webViewController);
  }
  
  _buildLoadingView(BuildContext context) {
    return Visibility(
      visible: controller.progress.value < 1.0,
      child: LinearProgressIndicator(
        minHeight: 2,
        backgroundColor: Colors.transparent,
        color: context.theme.primaryColor,
        value: controller.progress.value,
      ),
    );
  }

}
