import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_network/hi_network.dart';
import 'package:hi_navigator/hi_navigator.dart';
import '../core/constant.dart';
import '../core/datatype.dart';

class HiBaseController extends FullLifeCycleController {
  RxnString title = RxnString(null); // 采用响应式的原因在于便于在Web页面中使用
  var requestMode = HiRequestMode.none.obs;
  late Rx<HiUser> user;
  late Rx<HiConfiguration> configuration;
  late final HiProvider provider;
  late final HiNavigator navigator;
  late final Map<String, dynamic> parameters;
  late final StreamSubscription eventSubscription;

  bool get isLoading => requestMode.value == HiRequestMode.load;
  
  @override
  void onInit() {
    super.onInit();
    log('HiBaseController.onInit', tag: HiLogTag.frame);
    this.navigator = HiNavigator.shared();
    var myParameters = <String, dynamic>{};
    myParameters.addAll(Get.parameters);
    // parameters = Get.parameters;
    if (Get.arguments != null) {
      if (Get.arguments is Map<String, dynamic>) {
        myParameters.addAll(Get.arguments);
      } else {
        myParameters[R.parameters.arguments] = Get.arguments;
      }
    }
    parameters = myParameters;
    title.value = parameters.stringForKey(R.parameters.title);
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

  void reloadData() {
  }

}