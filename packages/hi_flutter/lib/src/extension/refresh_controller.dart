import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../core/datatype.dart';

extension RefreshControllerHiFlutterEx on RefreshController {
  void onSuccess(HiRequestMode mode, bool hasNext) {
    if (mode == HiRequestMode.pullRefresh) {
      refreshCompleted();
    } else if (mode == HiRequestMode.loadingMore) {
      loadComplete();
    }
    hasNext ? resetNoData() : loadNoData();
  }

  void onFailure(HiRequestMode mode) {
    if (mode == HiRequestMode.pullRefresh) {
      refreshFailed();
    } else if (mode == HiRequestMode.loadingMore) {
      loadFailed();
    }
  }
}