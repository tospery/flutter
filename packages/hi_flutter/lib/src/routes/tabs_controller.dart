import 'package:flutter/material.dart';
import 'package:hi_flutter/src/core/datatype.dart';
import 'package:hi_flutter/src/routes/base_controller.dart';

class HiTabsController<T extends TabItemType> extends HiBaseController {
  late final List<T> tabs;
  late final TabController tabController;

  HiTabsController({super.arguments = const {}});
}