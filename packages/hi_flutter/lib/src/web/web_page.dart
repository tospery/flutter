import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hi_flutter/src/page/hi_base_page.dart';
import 'package:hi_flutter/src/web/web_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiWebPage<WC extends HiWebController> extends HiBasePage<WC> {
  final FocusNode _focusNode = FocusNode();

  HiWebPage({super.key});

  @override
  void initState() {
    super.initState();
    if (GetPlatform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
      ),
      body: Stack(
        children: [
          TextField(
            focusNode: _focusNode,
          ),
          _buildWebView(),
          if (controller.isLoading.value) _buildLoadingView(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Text(
      controller.title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildWebView() {
    return WebView(
      initialUrl: controller.url.value,
      javascriptMode: JavascriptMode.unrestricted,
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
      navigationDelegate: (NavigationRequest navigation) {
        return navigationDecision(navigation);
      },
      onPageFinished: (_) {
        controller.loadFinished();
      },
    );
  }

  _buildLoadingView(BuildContext context) {
    if (!controller.isLoading.value) {
      return Container();
    }
    return Center(
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(4),
        child: SpinKitDoubleBounce(
          color: context.theme.primaryColor,
        ),
      ),
    );
  }

  NavigationDecision navigationDecision(NavigationRequest navigation) {
    return NavigationDecision.navigate;
  }
}
