import 'package:hi_flutter/hi_flutter.dart';

class HiListController<T> extends HiBaseController {
  var enablePullRefresh = false;
  var enableLoadingMore = false;
  var isFirst = true;
  var pageIndex = 1;
  var pageSize = 20;
  var requestMode = HiRequestMode.none.obs;
  RefreshController? refreshController;
  RxList<T> items = <T>[].obs;
  Rx<HiError?> error = Rx<HiError?>(null);

  @override
  void onInit() {
    super.onInit();
    enablePullRefresh =
        parameters.boolForKey(HiParameter.canRefresh) ?? false;
            enableLoadingMore =
        parameters.boolForKey(HiParameter.canLoadMore) ?? false;
  }

  void finish({List<T>? items, bool? hasNext, HiError? error}) {
    this.error.value = error;

    // if (mode != HiRequestMode.more) {
    //   items.clear();
    // }
    // items.addAll(result);
    if (this.requestMode.value != HiRequestMode.more) {
      this.items.clear();
    }
    if (this.error.value != null) {
      refreshController?.onFailure(requestMode.value);
      if (requestMode.value == HiRequestMode.more) {
        toast(error?.displayMessage ?? R.strings.loadingMoreFailure.tr);
      }
    } else {
      this.items.addAll(items ?? []);
      refreshController?.onSuccess(
          requestMode.value,
          hasNext ?? ((items?.length ?? 0) == this.pageSize),
      );
    }
    requestMode.value = HiRequestMode.none;
    update();
  }

  void onLoading(RefreshController refreshController) async {
    if (isFirst) {
      isFirst = false;
      this.refreshController = refreshController;
    }
    requestMode.value = HiRequestMode.loading;
    update();
    items.clear();
    var result = await fetchLocal() ?? [];
    if (result.length != 0) {
      items.addAll(result);
      refreshController?.onSuccess(
        requestMode.value,
        items.value.length == pageSize,
      );
    }
    requestRemote(mode: requestMode.value);
  }

  void onRefresh(RefreshController refreshController) {
    pageIndex = 1;
    requestMode.value = HiRequestMode.refresh;
    update();
    requestRemote(mode: requestMode.value);
  }

  void onMore(RefreshController refreshController) {
    pageIndex += 1;
    requestMode.value = HiRequestMode.more;
    update();
    requestRemote(mode: requestMode.value);
  }

  Future<List<T>?> fetchLocal() {
    return Future<List<T>?>.value(null);
  }

  void requestRemote({required HiRequestMode mode}) {}

}
