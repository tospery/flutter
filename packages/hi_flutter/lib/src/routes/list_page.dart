import 'package:flutter/material.dart';
import 'package:hi_flutter/src/routes/base_page.dart';
import 'package:hi_flutter/src/routes/list_controller.dart';
import 'package:hi_flutter/src/widget/refresh_view.dart';
import 'package:hi_flutter/src/extension/context.dart';
import 'package:hi_flutter/src/core/function.dart';
import 'package:hi_navigator/hi_navigator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class HiListPage<C extends HiListController> extends HiBasePage<C> {
  const HiListPage({super.key, super.tag});

  @override
  Widget body(BuildContext context) {
    return HiRefreshView<C>(
      tag: tag,
      enablePullRefresh: controller.enablePullRefresh,
      enableLoadingMore: controller.enableLoadingMore,
      buildLoadingView: buildLoadingView,
      buildSuccessView: buildSuccessView,
      buildFailureView: buildFailureView,
      buildHeaderView: buildHeaderView,
      buildFooterView: buildFooterView,
      // listView: listView(context),
    );
  }

  @override
  Widget buildSuccessView(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: safeArea.bottom),
      shrinkWrap: true,
      itemCount: controller.dataSource.length,
      itemBuilder: buildItemView,
      separatorBuilder: buildSeparator,
    );
  }

  Widget? buildItemView(BuildContext context, int index) => controller.dataSource[index].cell(onPressed: controller.doPressed, onChanged: controller.doChanged);
  Widget buildSeparator(BuildContext context, int index) => controller.dataSource[index].separator ?? Container();

  Widget buildHeaderView(BuildContext context, RefreshStatus? mode) {
    Widget header;
    log('刷新状态: $mode');
    if (mode == RefreshStatus.idle) {
      header = Text(
        R.strings.pullRefreshIdle.tr,
        style: context.textTheme.titleSmall,
      );
    } else if (mode == RefreshStatus.refreshing) {
      header = Lottie.asset(
        R.assets.animation.pullRefresh,
        width: 100,
        animate: true,
      );
    } else if (mode == RefreshStatus.failed) {
      header = Text(
        R.strings.pullRefreshFailure.tr,
        style: context.textTheme.titleSmall,
      );
    } else if (mode == RefreshStatus.completed) {
      header = Text(
        R.strings.pullRefreshSuccess.tr,
        style: context.textTheme.titleSmall,
      );
    } else {
      header = Text(
        R.strings.pullRefreshFreed.tr,
        style: context.textTheme.titleSmall,
      );
    }
    return SizedBox(
      height: 64,
      child: Center(child: header),
    );
  }

  Widget buildFooterView(BuildContext context, LoadStatus? mode) {
    Widget footer;
    log('更多状态: $mode');
    if (mode == LoadStatus.idle) {
      footer = Text(
        R.strings.loadingMoreIdle.tr,
        style: context.textTheme.titleSmall,
      );
    } else if (mode == LoadStatus.loading) {
      footer = Lottie.asset(
        R.assets.animation.loadingMore,
        width: 200,
        animate: true,
      );
    } else if (mode == LoadStatus.failed) {
      footer = Text(
        R.strings.loadingMoreFailure.tr,
        style: context.textTheme.titleSmall,
      );
    } else if (mode == LoadStatus.noMore) {
      footer = Text(
        R.strings.loadingMoreNoData.tr,
        style: context.textTheme.titleSmall,
      );
    } else {
      footer = Text(
        R.strings.loadingMoreIdle.tr,
        style: context.textTheme.titleSmall,
      );
    }
    return SizedBox(
      height: 60,
      child: Center(child: footer),
    );
  }
}
