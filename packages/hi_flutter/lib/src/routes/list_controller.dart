import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/core/datatype.dart';
import 'package:hi_flutter/src/flutter.dart';
import 'package:hi_flutter/src/extension/refresh_controller.dart';
import 'package:hi_flutter/src/routes/base_controller.dart';

class HiListController<M extends HiModel> extends HiBaseController<M> {
  late bool enablePullRefresh;
  late bool enableLoadingMore;
  late int pageIndex;
  late int pageSize;
  RefreshController? refreshController;

  HiListController({super.arguments = const {}});

  @override
  void onInit() {
    super.onInit();
    enablePullRefresh = parameters.boolValue(HiParameter.canRefresh) ?? false;
    enableLoadingMore = parameters.boolValue(HiParameter.canLoadMore) ?? false;
    pageIndex = parameters.intValue(HiParameter.pageIndex) ?? pageFirst;
    pageSize = parameters.intValue(HiParameter.pageSize) ??
        HiFlutter.shared().pageSize;
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void finish({List<M>? items, bool? hasNext, HiError? error}) {
    this.error.value = error;
    if (this.error.value != null) {
      refreshController?.onFailure(requestMode.value);
      if (requestMode.value == HiRequestMode.pullRefresh) {
        this.navigator.toast(
            error?.displayMessage?.tr ?? R.strings.pullRefreshFailure.tr);
      }
      if (requestMode.value == HiRequestMode.loadingMore) {
        this.navigator.toast(
            error?.displayMessage?.tr ?? R.strings.loadingMoreFailure.tr);
      }
    } else {
      if (requestMode.value == HiRequestMode.loadingMore) {
        pageIndex += 1;
      } else {
        pageIndex = pageFirst;
        dataSource.clear();
      }
      dataSource.addAll(items ?? []);
      refreshController?.onSuccess(
        requestMode.value,
        hasNext ?? ((items?.length ?? 0) == this.pageSize),
      );
    }
    requestMode.value = HiRequestMode.none;
    update();
  }

  void doPullRefresh() {
    requestMode.value = HiRequestMode.pullRefresh;
    update();
    requestRemote(requestMode.value, pageFirst);
  }

  void doLoadingMore() {
    requestMode.value = HiRequestMode.loadingMore;
    update();
    requestRemote(requestMode.value, pageIndex + 1);
  }
}
