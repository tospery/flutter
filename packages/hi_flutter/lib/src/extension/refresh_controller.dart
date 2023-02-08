import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../core/logger.dart';
import '../core/datatype.dart';

extension RefreshControllerEx on RefreshController {
  void onSuccess(HiRequestMode mode, bool hasNext) {
    if (mode == HiRequestMode.refresh) {
      refreshCompleted();
    } else if (mode == HiRequestMode.more) {
      loadComplete();
    }
    hasNext ? resetNoData() : loadNoData();
  }

  void onFailure(HiRequestMode mode) {
    if (mode == HiRequestMode.refresh) {
      refreshFailed();
    } else if (mode == HiRequestMode.more) {
      loadFailed();
    }
  }
}
