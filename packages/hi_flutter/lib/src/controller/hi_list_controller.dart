import 'package:hi_flutter/hi_flutter.dart';

class HiListController<T> extends HiBaseController {
  var enablePullRefresh = false;
  var enableLoadingMore = false;
  var isFirst = true;
  var pageIndex = 1;
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

  void finish({List? items, HiError? error}) {
    this.error.value = error;
    if (this.error.value != null) {
      refreshController?.onFailure(requestMode.value);
    } else {
      refreshController?.onSuccess(requestMode.value, false);
    }
    requestMode.value = HiRequestMode.none;
    update();
  }

  void onLoading(RefreshController refreshController) {
    if (!isFirst) {
      return;
    }
    this.refreshController = refreshController;
    reloadData();
  }

  void onRefresh(RefreshController refreshController) {
    pageIndex = 1;
    requestMode.value = HiRequestMode.refresh;
    update();
    requestData(mode: requestMode.value);
  }

  void onMore(RefreshController refreshController) {
    pageIndex += 1;
    requestMode.value = HiRequestMode.more;
    update();
    requestData(mode: requestMode.value);
  }

  void requestData({required HiRequestMode mode}) {}

  void reloadData() {
    requestMode.value = HiRequestMode.loading;
    update();
    requestData(mode: requestMode.value);
  }
}
