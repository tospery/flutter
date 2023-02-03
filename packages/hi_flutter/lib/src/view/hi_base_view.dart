import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HiBaseView<C extends GetxController> extends StatefulWidget {
  final String? tag = null;

  const HiBaseView({super.key});

  get updateId => null;
  C get controller => GetInstance().find<C>(tag: tag);

  @protected
  Widget build(BuildContext context);

  @override
  State<HiBaseView> createState() => _HiBaseViewState<C>();
}

class _HiBaseViewState<C extends GetxController> extends State<HiBaseView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<C>(
      id: widget.updateId,
      builder: (controller) {
        return widget.build(context);
      },
    );
  }

  @override
  void dispose() {
    // Get.delete<C>();
    super.dispose();
  }
}
