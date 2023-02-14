import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_network/hi_network.dart';
import 'package:hi_navigator/hi_navigator.dart';
import '../core/constant.dart';
import '../core/datatype.dart';
import 'package:hi_flutter/src/model/user.dart';
import 'package:hi_flutter/src/model/configuration.dart';

class HiBaseController extends GetxController {
  /// title通常不可变，故使用非响应式，如果需要变，则在具体controller中实现特定的响应式title
  String? title;
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

  void reloadData() {
  }

}