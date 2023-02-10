import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_dialog/src/impl/alert_view.dart';
import 'package:hi_dialog/src/impl/dialog.dart';

alert({
  String? title,
  String? content,
  String? backText,
  String? nextText,
  bool? backVisible,
  bool? nextVisible,
  VoidCallback? backTap,
  VoidCallback? nextTap,
  backKey = false,
}) {
  dismissDialog();
  Get.dialog(
    HiAlertView(
      title: title ?? '',
      content: content ?? '',
      backText : backText ?? '',
      nextText : nextText ?? '',
      backVisible : backVisible ?? false,
      nextVisible : nextVisible ?? false,
      backTap : backTap,
      nextTap : nextTap,
    ),
    transitionDuration:  const Duration(milliseconds: 500),
    barrierDismissible: backKey,
  );
}