import 'package:flutter/material.dart';
import 'package:hi_core/hi_core.dart';
import 'package:get/get.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

mixin ActionType {
  bool get isCancel;
  String get title;
}

Future<T?> sheet<T extends ActionType>({
  String? message,
  required List<T> actions,
  BuildContext? context,
}) {
  var ctx = context ?? Get.overlayContext;
  if (ctx == null) {
    return Future<T?>.value(null);
  }
  var myActions = actions.filter((e) => !e.isCancel).map((e) {
    return BottomSheetAction(
      title: Text(
        e.title,
        style: ctx.textTheme.titleMedium?.copyWith(
          color: ctx.theme.primaryColor,
        ),
      ),
      onPressed: (context) {
        Navigator.of(context).pop(e);
      },
    );
  }).toList();
  var myCancel = actions.firstWhereOrNull((e) => e.isCancel);
  return showAdaptiveActionSheet(
    context: ctx,
    title: message?.isNotEmpty ?? false ? Text(message!) : null,
    actions: myActions,
    cancelAction: myCancel != null
        ? CancelAction(
      title: Text(
        myCancel!.title,
        style: ctx.textTheme.titleMedium?.copyWith(
          color: ctx.theme.colorScheme.secondary,
        ),
      ),
    )
        : null,
  );
}
