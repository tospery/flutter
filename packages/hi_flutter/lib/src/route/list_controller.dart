import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_dialog/hi_dialog.dart';
import 'base_controller.dart';
import '../core/datatype.dart';
import '../extension/refresh_controller.dart';

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
    enablePullRefresh = parameters.boolForKey(HiParameter.canRefresh) ?? false;
    enableLoadingMore = parameters.boolForKey(HiParameter.canLoadMore) ?? false;
    pageFirst = parameters.intForKey(HiParameter.pageFirst) ?? 1;
    pageIndex = parameters.intForKey(HiParameter.pageIndex) ?? pageFirst;
    pageSize = parameters.intForKey(HiParameter.pageSize) ?? 20;
  }

  void onLoading(RefreshController refreshController) async {
    if (this.refreshController == null) {
      this.refreshController = refreshController;
    }
    requestMode.value = HiRequestMode.load;
    items.clear();
    update();
    var result = await fetchLocal() ?? [];
    if (result.length != 0) {
      items.addAll(result);
      refreshController?.onSuccess(
        requestMode.value,
        items.value.length == pageSize,
      );
    }
    requestRemote(requestMode.value, pageFirst);
  }

  void onRefresh(RefreshController refreshController) {
    requestMode.value = HiRequestMode.pullRefresh;
    update();
    requestRemote(requestMode.value, pageFirst);
  }

  void onMore(RefreshController refreshController) {
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
        toast(error?.displayMessage ?? R.strings.loadingMoreFailure.tr);
      }
    } else {
      if (requestMode.value != HiRequestMode.loadingMore) {
        pageIndex = pageFirst;
      } else {
        pageIndex += 1;
      }
      if (requestMode.value == HiRequestMode.pullRefresh) {
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

  Future<List<T>?> fetchLocal() {
    return Future<List<T>?>.value(null);
  }

  void requestRemote(HiRequestMode mode, int pageIndex) {}

}