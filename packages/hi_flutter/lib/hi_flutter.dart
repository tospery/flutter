library hi_flutter;

export 'package:hi_core/hi_core.dart';
export 'package:hi_cache/hi_cache.dart';
export 'package:hi_dialog/hi_dialog.dart';
export 'package:hi_network/hi_network.dart';
export 'package:get/get.dart';
export 'package:get/get_connect/http/src/request/request.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:pull_to_refresh/pull_to_refresh.dart';
export 'package:lottie/lottie.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:event_bus/event_bus.dart';
export 'src/core/constant.dart';
export 'src/core/datatype.dart';
export 'src/core/function.dart';
export 'src/extension/get.dart';
export 'src/extension/refresh_controller.dart';
export 'src/model/simple.dart';
export 'src/route/web_binding.dart';
export 'src/route/base_controller.dart';
export 'src/route/list_controller.dart';
export 'src/route/web_controller.dart';
export 'src/route/base_page.dart';
export 'src/route/list_page.dart';
export 'src/route/web_page.dart';
export 'src/utils/filter_formatter.dart';
export 'src/utils/length_formatter.dart';
export 'src/utils/package_manager.dart';
export 'src/utils/user_notifier.dart';
export 'src/widget/cell.dart';
export 'src/widget/simple_cell.dart';
export 'src/widget/navigation_bar.dart';
export 'src/widget/refresh_view.dart';
export 'src/widget/tab_bar_item.dart';

import 'package:hi_cache/hi_cache.dart';
import 'src/utils/package_manager.dart';

class HiFlutter {
  static Future<bool> ready() async {
    await HiCache.ready();
    await HiPackageManager.ready();
    return true;
  }
}