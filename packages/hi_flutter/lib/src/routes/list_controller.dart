import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_flutter/src/core/datatype.dart';
import 'package:hi_flutter/src/flutter.dart';
import 'package:hi_flutter/src/extension/refresh_controller.dart';
import 'package:hi_flutter/src/routes/base_controller.dart';

class HiListController<T> extends HiBaseController {
  late bool enablePullRefresh;
  late bool enableLoadingMore;
  late int pageFirst;
  late int pageIndex;
  late int pageSize;
  RefreshController? refreshController;
  RxList<T> items = <T>[].obs;
  Rx<HiError?> error = Rx<HiError?>(null);

  @override
  void onInit() {
    super.onInit();
    enablePullRefresh = parameters.boolForKey(R.parameters.canRefresh) ?? false;
    enableLoadingMore = parameters.boolForKey(R.parameters.canLoadMore) ?? false;
    pageFirst = parameters.intForKey(R.parameters.pageFirst) ?? 1;
    pageIndex = parameters.intForKey(R.parameters.pageIndex) ?? pageFirst;
    pageSize = parameters.intForKey(R.parameters.pageSize) ?? HiFlutter.shared().pageSize;
  }

  void doRefresh() {
    log('doRefresh');
    requestMode.value = HiRequestMode.pullRefresh;
    update();
    requestRemote(requestMode.value, pageFirst);
  }

  void doLoadingMore() {
    log('doLoadingMore');
    requestMode.value = HiRequestMode.loadingMore;
    update();
    requestRemote(requestMode.value, pageIndex + 1);
  }

  void finish({List<T>? items, bool? hasNext, HiError? error}) {
    this.error.value = error;
    // if (requestMode.value != HiRequestMode.more) {
    //   this.items.clear();
    // }
    if (this.error.value != null) {
      refreshController?.onFailure(requestMode.value);
      if (requestMode.value == HiRequestMode.loadingMore) {
        // toast(error?.displayMessage ?? R.strings.loadingMoreFailure.tr);
        this.navigator.toast(error?.displayMessage ?? R.strings.loadingMoreFailure.tr);
      }
    } else {
      if (requestMode.value == HiRequestMode.loadingMore) {
        pageIndex += 1;
      } else {
        pageIndex = pageFirst;
        this.items.clear();
      }
      this.items.addAll(items ?? []);
      refreshController?.onSuccess(
        requestMode.value,
        hasNext ?? ((items?.length ?? 0) == this.pageSize),
      );
    }
    requestMode.value = HiRequestMode.none;
    update();
  }

  @override
  void reloadData() async {
    requestMode.value = HiRequestMode.load;
    items.clear();
    update();
    var models = await fetchLocal();
    if (models.isNotEmpty) {
      items.addAll(models);
      refreshController?.onSuccess(
        requestMode.value,
        items.value.length == pageSize,
      );
      update();
    }
    requestRemote(requestMode.value, pageFirst);
  }

  Future<List<T>> fetchLocal() async => Future<List<T>>.value([]);

  void requestRemote(HiRequestMode mode, int pageIndex) {}

}