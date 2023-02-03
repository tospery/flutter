import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../core/datatype.dart';

extension RefreshControllerEx on RefreshController {
  void onSuccess(HiRequestMode mode, bool hasNext) {
    if (mode == HiRequestMode.refresh) {
      refreshCompleted();
    } else if (mode == HiRequestMode.more) {
      loadComplete();
    }
    if (!hasNext) {
      loadNoData();
    }
    // if (mode == HiRequestMode.refresh) {
    //   Get.toast(R.strings.pullRefreshSuccess.tr);
    // }
  }

  void onFailure(HiRequestMode mode) {
    if (mode == HiRequestMode.refresh) {
      refreshFailed();
    } else if (mode == HiRequestMode.more) {
      loadFailed();
    }
  }
}
