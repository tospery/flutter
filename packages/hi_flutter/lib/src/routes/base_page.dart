import 'package:flutter/material.dart';
import 'package:hi_flutter/src/routes/base_controller.dart';
import 'package:hi_flutter/src/routes/tabbar_controller.dart';
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
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  PreferredSizeWidget? appBar(BuildContext context) {
    return controller.hideAppBar
        ? null
        :
        GFAppBar(
          title: (controller.title.value?.isEmpty ?? true) ? null : Text(
              controller.title.value!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.theme.tsFg(22),
          ),
          leading: ((navigator?.canPop() ?? false) || (navigator?.userGestureInProgress ?? false)) ? InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.theme.fgColor,
              size: 24,
            ),
          ) : null,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              color: context.theme.fgColor.sd600,
              height: 1.0,
              indent: 0,
            ),
          ),
        );
    // AppBar(
    //   title: controller.title.value != null
    //       ? Text(
    //     controller.title.value!,
    //     maxLines: 1,
    //     overflow: TextOverflow.ellipsis,
    //   )
    //       : null,
    //   bottom: PreferredSize(
    //     preferredSize: Size.fromHeight(1.0),
    //     child: Divider(
    //       color: context.theme.fgColor.sd600,
    //       height: 1.0,
    //       indent: 0,
    //     ),
    //   ),
    // );
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

  Widget? bottomNavigationBar(BuildContext context) => null;

  Widget buildLoadingView(BuildContext context) => Lottie.asset(
    R.assets.animation.loading,
    width: 120,
    height: 120,
    animate: true,
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
          newBox(height: 20),
          controller.error.value?.displayTitle?.tr.isEmpty ?? true
              ? Container()
              : Text(
            controller.error.value!.displayTitle!.tr,
            style: context.theme.ts900(18),
          ),
          newBox(height: 2),
          controller.error.value?.displayMessage?.tr.isEmpty ?? true
              ? Container()
              : Text(
            controller.error.value!.displayMessage!.tr,
            style: context.theme.ts800(16),
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
        WidgetsBindingObserver,
        RouteAware {
  @override
  void initState() {
    super.initState();
    if (widget.lifecycle != null) {
      WidgetsBinding.instance.addObserver(this);
    }
    if (widget.controller is HiTabBarController) {
      var tabBarController = widget.controller as HiTabBarController;
      tabBarController.tabController =
          TabController(length: tabBarController.tabs.length, vsync: this);
      tabBarController.tabController.addListener(() {
        if (!tabBarController.tabController.indexIsChanging) {
          log('选中tab: ${tabBarController.tabController.index}');
          appear(tabBarController.tabController.index);
        }
      });
      var index = Get.parameters.intValue(HiParameter.index) ?? 0;
      tabBarController.tabController.index = index;
    }
    widget.initState();
  }

  void appear(int index) {
    // if (index == 3) {
    //   var personalPage = pages[index] as PersonalPage;
    //   personalPage.controller.appear();
    // }
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
    if (widget.controller is HiTabBarController) {
      var tabBarController = widget.controller as HiTabBarController;
      tabBarController.tabController.dispose();
    }
    Get.delete<C>(tag: widget.tag);
    if (widget.lifecycle != null) {
      WidgetsBinding.instance.removeObserver(this);
    }
    HiNavigator.shared().routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (widget.lifecycle != null) {
      widget.lifecycle(state);
    }
    HiNavigator.shared().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didPush() {
    log('首页生命周期: didPush->viewWillAppear');
  }

  @override
  void didPop() {
    log('首页生命周期: didPop->viewWillDisappear');
  }

  @override
  void didPopNext() {
    log('首页生命周期: didPopNext->viewWillAppear');
    if (widget.controller is HiTabBarController) {
      var tabBarController = widget.controller as HiTabBarController;
      appear(tabBarController.tabController.index);
    }
  }

  @override
  void didPushNext() {
    log('首页生命周期: didPushNext->viewWillDisappear');
  }
}
