import 'package:flutter/material.dart';
import 'package:hi_flutter/src/core/datatype.dart';
import 'package:hi_flutter/src/routes/base_page.dart';
import 'package:hi_flutter/src/extension/context.dart';
import 'package:hi_flutter/src/routes/tabs_controller.dart';
import 'package:hi_flutter/src/widget/tab_bar_item.dart';
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
    if (!controller.isTop) {
      return ListView(
        children: [
          _buildTabBar(context),
          _buildTabBarView(context),
        ],
      );
    }
    return _buildTabBarView(context);
  }

  Widget? bottomNavigationBar(BuildContext context) {
    if (!controller.isTop) {
      return null;
    }
    return GFTabBar(
      length: controller.tabs.length,
      controller: controller.tabController,
      tabs: controller.tabs.map((e) => HiTabBarItem(title: e.title, image: e.image,)).toList(),
      indicator: const BoxDecoration(),
      labelColor: context.theme.primaryColor,
      tabBarHeight: controller.tabBarHeight + context.safeArea.bottom,
      tabBarColor: context.theme.bgColor,
      unselectedLabelColor: context.theme.fgColor,
    );
    // return Container(
    //   color: Colors.white,
    //   child: SafeArea(
    //     bottom: true,
    //     child: Container(
    //       height: 65,
    //       color: Colors.white,
    //       // decoration: hiShadowDecoration(radius: 0),
    //       child: TabBar(
    //         indicator: const BoxDecoration(),
    //         labelColor: context.theme.primaryColor, //Colors.red,
    //         unselectedLabelColor: Colors.black,
    //         controller: tabController,
    //         tabs: [
    //           HiTabBarItem(
    //             title: R.strings.trending.tr,
    //             iconData: Icons.turned_in,
    //           ),
    //           HiTabBarItem(
    //             title: R.strings.events.tr,
    //             iconData: Icons.send,
    //           ),
    //           HiTabBarItem(
    //             title: R.strings.favorited.tr,
    //             iconData: Icons.favorite,
    //           ),
    //           HiTabBarItem(
    //             title: R.strings.personal.tr,
    //             iconData: Icons.person,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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
    // log("看看高度: ${context.height}, ${context.safeArea}");
    return GFTabBarView(
      height: context.height - controller.tabBarHeight - context.safeArea.bottom,
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