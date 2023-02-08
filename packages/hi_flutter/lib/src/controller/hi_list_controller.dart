import 'package:hi_flutter/hi_flutter.dart';

class HiListController<T> extends HiBaseController {
  var enablePullRefresh = false;
  var enableLoadingMore = false;
  var isFirst = true;
  var pageFirst = 1;
  var pageIndex = 1;
  var pageSize = 20;
  var requestMode = HiRequestMode.none.obs;
  RefreshController? refreshController;
  RxList<T> items = <T>[].obs;
  Rx<HiError?> error = Rx<HiError?>(null);

  @override
  void onInit() {
    super.onInit();
    enablePullRefresh = parameters.boolForKey(HiParameter.canRefresh) ?? false;
    enableLoadingMore = parameters.boolForKey(HiParameter.canLoadMore) ?? false;
    pageIndex = pageFirst;
  }

  void onLoading(RefreshController refreshController) async {
    if (isFirst) {
      isFirst = false;
      this.refreshController = refreshController;
    }
    requestMode.value = HiRequestMode.loading;
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
    requestMode.value = HiRequestMode.refresh;
    update();
    requestRemote(requestMode.value, pageFirst);
  }

  void onMore(RefreshController refreshController) {
    requestMode.value = HiRequestMode.more;
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
      if (requestMode.value == HiRequestMode.more) {
        toast(error?.displayMessage ?? R.strings.loadingMoreFailure.tr);
      }
    } else {
      if (requestMode.value != HiRequestMode.more) {
        pageIndex = pageFirst;
      } else {
        pageIndex += 1;
      }
      if (requestMode.value == HiRequestMode.refresh) {
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
