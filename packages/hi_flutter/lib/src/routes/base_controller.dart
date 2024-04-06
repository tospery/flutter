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
  var hideAppBar = false.obs;
  var requestMode = HiRequestMode.none.obs;
  late Rx<HiUser> user;
  late Rx<HiConfiguration> configuration;
  late final HiProvider provider;
  late final HiNavigator navigator;
  late final StreamSubscription eventSubscription;
  Map<String, dynamic> parameters;

  bool get isLoading => requestMode.value == HiRequestMode.load;

  HiBaseController({this.parameters = const {}});

  @override
  void onInit() {
    super.onInit();
    this.navigator = HiNavigator.shared();
    var myParameters = <String, dynamic>{};
    myParameters.addAll(Get.parameters);
    if (Get.arguments != null) {
      if (Get.arguments is Map<String, dynamic>) {
        myParameters.addAll(Get.arguments);
      } else {
        myParameters[HiParameter.arguments] = Get.arguments;
      }
    }
    myParameters.addAll(parameters);
    parameters = myParameters;
    log('页面参数($instanceName)：$parameters', tag: HiLogTag.frame);
    title.value = parameters.value<String>(HiParameter.title);
    hideAppBar.value = parameters.value<bool>(HiParameter.hideAppBar) ?? false;
    user = Get.find<HiUser>().obs;
    configuration = Get.find<HiConfiguration>().obs;
    provider = Get.find<HiProvider>();
    eventSubscription = eventBus.on().listen((event) {
      if (event is! Map<String, dynamic>) {
        return;
      }
      final model = event[HiParameter.model];
      final needReload = event.value<bool>(HiParameter.needReload) ?? false;
      if (model is HiUser) {
        updateUser(model, needReload: needReload);
      }
      if (model is HiConfiguration) {
        updateConfiguration(model, needReload: needReload);
      }
    });
  }

  @override
  void dispose() {
    eventSubscription.cancel();
    super.dispose();
  }

  void updateUser(HiUser user, {bool? needReload}) {
    this.user.value = user;
    update();
    if (needReload ?? false) {
      reloadData();
    }
  }

  void updateConfiguration(HiConfiguration configuration, {bool? needReload}) {
    this.configuration.value = configuration;
    update();
    if (needReload ?? false) {
      reloadData();
    }
  }

  void reloadData() {}
}
