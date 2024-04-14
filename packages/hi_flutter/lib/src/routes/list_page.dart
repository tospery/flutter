import 'package:flutter/material.dart';
import 'base_page.dart';
import 'list_controller.dart';
import '../widget/refresh_view.dart';
import 'package:hi_navigator/hi_navigator.dart';

abstract class HiListPage<C extends HiListController> extends HiBasePage<C> {
  const HiListPage({super.key, super.tag});

  @override
  Widget body(BuildContext context) {
    return HiRefreshView<C>(
      tag: tag,
      enablePullRefresh: controller.enablePullRefresh,
      enableLoadingMore: controller.enableLoadingMore,
      listView: listView(context),
    );
  }

  ListView listView(BuildContext context) {
    return ListView();
  }

  @override
  Widget buildLoadingView(BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.isLoading,
        child: SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset(
            R.assets.animation.loading,
            width: 200,
            height: 200,
            animate: true,
          ),
        ),
      ),
    );
  }
}
