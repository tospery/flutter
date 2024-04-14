import 'dart:async';
import 'package:hi_flutter/src/core/constant.dart';
import 'package:hi_flutter/src/core/datatype.dart';
import 'package:hi_network/hi_network.dart';
import 'package:hi_navigator/hi_navigator.dart';

class HiBaseController<T> extends FullLifeCycleController {
  var title = RxnString(null); // 采用响应式的原因在于便于在Web页面中使用
  var hideAppBar = false.obs;
  var requestMode = HiRequestMode.none.obs;
  var dataSource = Rx<dynamic>(null);
  var error = Rx<HiError?>(null);
  late Rx<HiUser> user;
  late Rx<HiConfiguration> configuration;
  late final String url;
  late final HiProvider provider;
  late final HiNavigator navigator;
  late final StreamSubscription eventSubscription;
  Map<String, dynamic> parameters;

  T? get model => (dataSource.value is T) ? dataSource.value as T? : null;

  bool get isLoading => requestMode.value == HiRequestMode.load;
  bool get isUpdating => requestMode.value == HiRequestMode.update;

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
    url = parameters.stringValue(HiParameter.url) ?? "";
    title.value = parameters.stringValue(HiParameter.title);
    hideAppBar.value = parameters.boolValue(HiParameter.hideAppBar) ?? false;
    user = Get.find<HiUser>().obs;
    configuration = Get.find<HiConfiguration>().obs;
    provider = Get.find<HiProvider>();
    eventSubscription = eventBus.on().listen((event) {
      if (event is! Map<String, dynamic>) {
        return;
      }
      final model = event[HiParameter.model];
      final needReload = event.boolValue(HiParameter.needReload) ?? false;
      if (model is HiUser) {
        updateUser(model, needReload: needReload);
      }
      if (model is HiConfiguration) {
        updateConfiguration(model, needReload: needReload);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    reloadData();
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
