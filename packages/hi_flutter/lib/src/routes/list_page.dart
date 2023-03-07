import 'package:flutter/material.dart';
import 'base_page.dart';
import 'list_controller.dart';
import '../widget/refresh_view.dart';

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
}
