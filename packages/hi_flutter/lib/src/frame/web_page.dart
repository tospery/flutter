import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_controller.dart';
import 'base_page.dart';
import '../core/datatype.dart';

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
          if (controller.isLoading) _buildLoadingView(context),
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
      initialUrl: controller.url,
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
    if (!controller.isLoading) {
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
