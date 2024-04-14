import 'package:flutter/material.dart';
import 'package:hi_flutter/src/routes/base_controller.dart';
import 'package:hi_flutter/src/routes/tabs_controller.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_navigator/hi_navigator.dart';

/// 可持久化保存GetxController状态的Widget基类,用于绑定Controller
/// 由于在TabBarView中切换页面会导致状态重置，从而GetxController销毁
/// 再次切换时需要重新拉取所有信息，体验非常差，因此需要继承AutomaticKeepAliveClientMixin
/// 来达到拦截状态销毁的目的
abstract class HiBasePage<C extends HiBaseController> extends StatefulWidget {
  final String? tag;

  const HiBasePage({super.key, this.tag});

  get updateId => null;
  get lifecycle => null;
  C get controller => GetInstance().find<C>(tag: tag);

  void initState() {
    log('HiBasePage.initState', tag: HiLogTag.frame);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
    );
  }

  PreferredSizeWidget? appBar(BuildContext context) {
    return controller.hideAppBar.value
        ? null
        : AppBar(
            title: controller.title.value != null
                ? Text(
                    controller.title.value!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
          );
  }

  Widget body(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => Visibility(
              visible: controller.isLoading,
              child: buildLoadingView(context),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading == false &&
                  controller.error.value == null,
              child: buildSuccessView(context),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading == false &&
                  controller.error.value != null,
              child: buildFailureView(context),
            ),
          ),
          buildFailureView(context),
        ],
      ),
    );
  }

  Widget buildLoadingView(BuildContext context) => SizedBox(
        width: 200,
        height: 200,
        child: Lottie.asset(
          R.assets.animation.loading,
          width: 200,
          height: 200,
          animate: true,
        ),
      );

  Widget buildSuccessView(BuildContext context) => Container();

  Widget buildFailureView(BuildContext context) => GestureDetector(
        onTap: controller.reloadData,
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.error.value?.displayImage?.isEmpty ?? true
                  ? Container()
                  : newImageWidget(
                      controller.error.value!.displayImage!,
                      width: context.width / 4.0,
                    ),
              controller.error.value?.displayTitle?.tr.isEmpty ?? true
                  ? Container()
                  : Text(
                      controller.error.value!.displayTitle!.tr,
                      style: context.textTheme.titleLarge,
                    ),
              controller.error.value?.displayMessage?.tr.isEmpty ?? true
                  ? Container()
                  : Text(
                      controller.error.value!.displayMessage!.tr,
                      style: context.textTheme.titleMedium,
                    ),
            ],
          ),
        ),
      );

  @override
  HiBasePageState createState() => HiBasePageState<C>();
}

class HiBasePageState<C extends HiBaseController> extends State<HiBasePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HiBasePage>,
        WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (widget.lifecycle != null) {
      WidgetsBinding.instance.addObserver(this);
    }
    if (widget.controller is HiTabsController) {
      var tabsController = widget.controller as HiTabsController;
      tabsController.tabController =
          TabController(length: tabsController.tabs.length, vsync: this);
    }
    widget.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<C>(
      id: widget.updateId,
      tag: widget.tag,
      builder: (controller) {
        return widget.build(context);
      },
    );
  }

  @override
  void dispose() {
    if (widget.controller is HiTabsController) {
      var tabsController = widget.controller as HiTabsController;
      tabsController.tabController.dispose();
    }
    Get.delete<C>(tag: widget.tag);
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
