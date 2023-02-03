import 'dart:async';

import 'package:get/get.dart';
import '../core/constant.dart';
import '../core/parameter.dart';
import '../extension/map.dart';
import '../model/hi_user.dart';
import '../utils/hi_provider.dart';
import '../model/hi_configuration.dart';

class HiBaseController extends GetxController {
  /// title通常不可变，故使用非响应式，如果需要变，则在具体controller中实现特定的响应式title
  String? title;
  // var parameters = <String, dynamic>{};
  late final Map<String, dynamic> parameters;
  late Rx<HiUser> user;
  late Rx<HiConfiguration> configuration;
  late HiProvider provider;
  late StreamSubscription eventSubscription;

  @override
  void onInit() {
    super.onInit();
    var myParameters = <String, dynamic>{};
    myParameters.addAll(Get.parameters);
    // parameters = Get.parameters;
    if (Get.arguments != null) {
      if (Get.arguments is Map<String, dynamic>) {
        myParameters.addAll(Get.arguments);
      } else {
        myParameters[HiParameter.arguments] = Get.arguments;
      }
    }
    parameters = myParameters;
    title = parameters.stringForKey(HiParameter.title);
    user = Get.find<HiUser>().obs;
    configuration = Get.find<HiConfiguration>().obs;
    provider = Get.find<HiProvider>();
    eventSubscription = eventBus.on().listen((event) {
      if (event is HiUser) {
        updateUser(event);
      }
      if (event is HiConfiguration) {
        updateConfiguration(event);
      }
    });
  }

  @override
  void dispose() {
    eventSubscription.cancel();
    super.dispose();
  }

  void updateUser(HiUser user) {
    this.user.value = user;
    update();
  }

  void updateConfiguration(HiConfiguration configuration) {
    this.configuration.value = configuration;
    update();
  }

}
