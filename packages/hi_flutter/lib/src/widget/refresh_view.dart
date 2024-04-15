import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:hi_navigator/hi_navigator.dart';
import 'package:hi_flutter/src/routes/list_controller.dart';

typedef HiBuildHeaderView = Widget Function(BuildContext context, RefreshStatus? mode);
typedef HiBuildFooterView = Widget Function(BuildContext context, LoadStatus? mode);

class HiRefreshView<C extends HiListController> extends StatefulWidget {
  final bool enablePullRefresh;
  final bool enableLoadingMore;
  final String? tag;
  final VoidCallback? onPullRefresh;
  final VoidCallback? onLoadingMore;
  final HiBuildWidget? buildLoadingView;
  final HiBuildWidget? buildSuccessView;
  final HiBuildWidget? buildFailureView;
  final HiBuildHeaderView? buildHeaderView;
  final HiBuildFooterView? buildFooterView;
  // final ListView listView;

  C get getController => GetInstance().find<C>(tag: tag);

  const HiRefreshView({
    super.key,
    this.enablePullRefresh = false,
    this.enableLoadingMore = false,
    this.tag,
    this.onPullRefresh,
    this.onLoadingMore,
    this.buildLoadingView,
    this.buildSuccessView,
    this.buildFailureView,
    this.buildHeaderView,
    this.buildFooterView,
    //required this.listView,
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
    widget.getController.refreshController = _refreshController;
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
          Obx(
            () => Visibility(
              visible: widget.getController.isLoading,
              child: widget.buildLoadingView == null
                  ? Container()
                  : widget.buildLoadingView!(context),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !widget.getController.isLoading &&
                  widget.getController.error.value == null &&
                  widget.getController.dataSource.isNotEmpty,
              // child: widget.buildSuccessView == null
              //     ? Container()
              //     : widget.buildSuccessView!(context),
              child: ScrollConfiguration(
                behavior: HiOverScrollBehavior(),
                child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: widget.enablePullRefresh,
                enablePullUp: widget.enableLoadingMore,
                onRefresh: widget.getController.doPullRefresh,
                onLoading: widget.getController.doLoadingMore,
                header: widget.buildHeaderView == null ? null : CustomHeader(builder: widget.buildHeaderView!),
                footer: widget.buildFooterView == null ? null : CustomFooter(builder: widget.buildFooterView!),
                child: widget.buildSuccessView == null ? null : widget.buildSuccessView!(context),
                  // child: widget.listView,
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !widget.getController.isLoading &&
                  widget.getController.error.value != null &&
                  widget.getController.dataSource.isEmpty,
              child: widget.buildFailureView == null
                  ? Container()
                  : widget.buildFailureView!(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
