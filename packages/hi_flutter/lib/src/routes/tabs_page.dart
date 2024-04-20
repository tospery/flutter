import 'package:flutter/material.dart';
import 'package:hi_flutter/src/core/datatype.dart';
import 'package:hi_flutter/src/routes/base_page.dart';
import 'package:hi_flutter/src/extension/context.dart';
import 'package:hi_flutter/src/routes/tabs_controller.dart';
import 'package:hi_navigator/hi_navigator.dart';

abstract class HiTabsPage<C extends HiTabsController> extends HiBasePage<C> {

  const HiTabsPage({super.key});

  @override
  initState() {
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    // return SafeArea(
    //   top: true,
    //   child: ListView(
    //     children: [
    //       _buildTabBar(context),
    //       _buildTabBarView(context),
    //     ],
    //   ),
    // );
    return ListView(
      children: [
        _buildTabBar(context),
        _buildTabBarView(context),
      ],
    );
  }

  _buildTabBar(BuildContext context) {
    return GFTabBar(
      length: controller.tabs.length,
      controller: controller.tabController,
      tabs: controller.tabs.map((e) => buildTabItem(context, e)).toList(),
      indicatorColor: context.theme.primaryColor,
      labelColor: context.theme.primaryColor,
      labelPadding: EdgeInsets.zero, // const EdgeInsets.all(8),
      tabBarColor: context.theme.bgColor,
      unselectedLabelColor: context.theme.fgColor,
      tabBarHeight: controller.tabBarHeight,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    );
  }

  _buildTabBarView(BuildContext context) {
    // return Container(
    //   height: context.height - kToolbarHeight - controller.tabBarHeight,
    //   child: GFTabBarView(
    //   controller: controller.tabController,
    //   children: controller.tabs.map((e) => buildTabPage(context, e)).toList(),
    // ),
    // );
    // log("看看上下：${context.safeArea}");
    return GFTabBarView(
      height: context.height - context.safeArea.top - kToolbarHeight - controller.tabBarHeight,
      controller: controller.tabController,
      children: controller.tabs.map((e) => buildTabPage(context, e)).toList(),
    );
  }

  Widget buildTabItem(BuildContext context, TabItemType tab) {
    return Text(tab.title ?? '');
  }

  Widget buildTabPage(BuildContext context, TabItemType tab) {
    return Center(
      child: Text(tab.title ?? ''),
    );
  }

}