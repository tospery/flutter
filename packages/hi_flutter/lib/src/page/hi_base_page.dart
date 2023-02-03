import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/hi_base_controller.dart';

/// 可持久化保存GetxController状态的Widget基类,用于绑定Controller
/// 由于在TabBarView中切换页面会导致状态重置，从而GetxController销毁
/// 再次切换时需要重新拉取所有信息，体验非常差，因此需要继承AutomaticKeepAliveClientMixin
/// 来达到拦截状态销毁的目的
abstract class HiBasePage<C extends HiBaseController> extends StatefulWidget {
  final String? tag = null;

  const HiBasePage({super.key});

  get updateId => null;
  get lifecycle => null;
  C get controller => GetInstance().find<C>(tag: tag);

  void initState() {}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
    );
  }

  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(controller.title ?? ''),
    );
  }

  Widget body(BuildContext context) {
    return Container();
  }

  @override
  HiBasePageState createState() => HiBasePageState<C>();
}

class HiBasePageState<C extends HiBaseController> extends State<HiBasePage>
    with AutomaticKeepAliveClientMixin<HiBasePage>, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (widget.lifecycle != null) {
      WidgetsBinding.instance.addObserver(this);
    }
    widget.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<C>(
      id: widget.updateId,
      builder: (controller) {
        return widget.build(context);
      },
    );
  }

  @override
  void dispose() {
    Get.delete<C>();
    if (widget.lifecycle != null) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (widget.lifecycle != null) {
      widget.lifecycle(state);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
