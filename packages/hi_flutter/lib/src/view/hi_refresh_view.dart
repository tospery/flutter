import 'package:flutter/material.dart';
import 'package:hi_flutter/hi_flutter.dart';

class HiRefreshView<C extends HiListController>
    extends StatefulWidget {
  final bool enablePullRefresh;
  final bool enableLoadingMore;
  final String? tag;
  final VoidCallback? onPullRefresh;
  final VoidCallback? onLoadingMore;
  final ListView listView;

  C get getController => GetInstance().find<C>(tag: tag);

  const HiRefreshView({
    super.key,
    this.enablePullRefresh = true,
    this.enableLoadingMore = false,
    this.tag,
    this.onPullRefresh,
    this.onLoadingMore,
    required this.listView,
  });

  @override
  State<HiRefreshView> createState() => HiRefreshViewState();
}

class HiRefreshViewState extends State<HiRefreshView>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.getController.onLoading(_refreshController);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildLoadingView(),
          // _buildEmptyView(),
          _buildSuccessView(),
          _buildFailureView(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _buildLoadingView() {
    return Obx(
      () => Visibility(
        visible: widget.getController.items.isEmpty &&
            widget.getController.error.value == null,
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

  _buildSuccessView() {
    return Obx(
      () => Visibility(
        visible: widget.getController.items.isNotEmpty &&
            widget.getController.error.value == null,
        child: ScrollConfiguration(
          behavior: HiOverScrollBehavior(),
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: widget.enablePullRefresh,
            enablePullUp: widget.enableLoadingMore,
            onRefresh: () => widget.getController.onRefresh(_refreshController),
            onLoading: () => widget.getController.onMore(_refreshController),
            header: CustomHeader(builder: _buildHeader),
            footer: CustomFooter(builder: _buildFooter),
            child: widget.listView,
          ),
        ),
      ),
    );
  }

  _buildFailureView() {
    return Obx(
      () => Visibility(
        visible: widget.getController.error.value != null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _displayErrorImage(),
            _displayErrorTitle(),
            _displayErrorMessage(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, RefreshStatus? mode) {
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

  Widget _buildFooter(BuildContext context, LoadStatus? mode) {
    Widget footer;
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

  _displayErrorImage() {
    var urlString = widget.getController.error.value?.displayImage;
    if (urlString?.isEmpty ?? true) {
      return Container();
    }
    return hiImage(urlString!, width: context.width / 4.0);
  }

  _displayErrorTitle() {
    var title = widget.getController.error.value?.displayTitle;
    if (title?.isEmpty ?? true) {
      return Container();
    }
    return Text(
      title!,
      style: context.textTheme.titleLarge,
    );
  }

  _displayErrorMessage() {
    var message = widget.getController.error.value?.displayMessage;
    if (message?.isEmpty ?? true) {
      return Container();
    }
    return Text(
      message!,
      style: context.textTheme.titleMedium,
    );
  }
}
