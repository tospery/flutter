import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hi_core/hi_core.dart';
import 'package:hi_cache/hi_cache.dart';

Future<bool> storeObject<M extends HiModel>(
  M model, {
  String? id,
  bool? useDatabase,
  bool? isReactive,
}) async {
  await HiCache.shared().storeObject(model, id: id, useDatabase: useDatabase);
  if (isReactive ?? false) {
    if (model is HiUser) {
      Get.replace<HiUser>(model);
    }
    if (model is HiConfiguration) {
      Get.replace<HiConfiguration>(model);
    }
  }
  return true;
}

Future<M?> fetchObject<M extends HiModel>(
  M Function(Map<String, dynamic>) fromJson, {
  String? id,
  bool? useDatabase,
}) =>
    HiCache.shared().fetchObject(fromJson, id: id, useDatabase: useDatabase);

Future<bool> storeArray<M extends HiModel>(
  List<M> models, {
  String? page,
}) =>
    HiCache.shared().storeArray(models, page: page);

Future<List<M>> fetchArray<M extends HiModel>(
  M Function(Map<String, dynamic>) fromJson, {
  String? page,
}) =>
    HiCache.shared().fetchArray(fromJson);

double metricWidth(
  double width, {
  BuildContext? context,
}) {
  final designWidth = 393.0;
  var deviceWidth = (context ?? Get.overlayContext)?.width ?? designWidth;
  return width / designWidth * deviceWidth;
}

double metricHeight(
  double height, {
  BuildContext? context,
}) {
  final designHeight = 852.0;
  var deviceHeight = (context ?? Get.overlayContext)?.width ?? designHeight;
  return height / designHeight * deviceHeight;
}

SizedBox hiSpace({
  double width = 1,
  double height = 1,
}) =>
    SizedBox(
      width: width,
      height: height,
    );

Border hiBorder({
  BuildContext? context,
  Color? color,
  double? width,
  bool top = false,
  bool right = false,
  bool bottom = false,
  bool left = false,
}) {
  var borderSide = Divider.createBorderSide(
    context,
    width: width,
    color: color,
  );
  return Border(
    top: top ? borderSide : BorderSide.none,
    right: right ? borderSide : BorderSide.none,
    bottom: bottom ? borderSide : BorderSide.none,
    left: left ? borderSide : BorderSide.none,
  );
}

UnderlineInputBorder hiUnderlineBorder({
  BuildContext? context,
  double? width,
  Color? color,
}) {
  return UnderlineInputBorder(
    borderSide: Divider.createBorderSide(
      context,
      width: width ?? context?.theme.dividerTheme.thickness,
      color: color ?? context?.theme.dividerTheme.color,
    ),
    borderRadius: BorderRadius.zero,
  );
}

OutlineInputBorder hiOutlineBorder({
  Color? color,
  double width = 1.0,
  double radius = 4.0,
  BuildContext? context,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    borderSide: Divider.createBorderSide(
      context,
      width: width,
      color: color ?? (context ?? Get.overlayContext)?.theme.dividerTheme.color,
    ),
  );
}

BoxDecoration hiShadowDecoration({
  Color? color = Colors.white,
  double radius = 10,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: const [
      BoxShadow(
        offset: Offset(-3.0, 3.0),
        blurRadius: 10,
        color: Color(0x66E0E6FD),
        spreadRadius: 4,
      )
    ],
  );
}

Icon hiIndicator({
  BuildContext? context,
  Color? color,
  double? size,
}) =>
    Icon(
      Icons.navigate_next,
      color: color ?? context?.theme.indicatorColor,
      size: size ?? 24,
    );

// ///分割线 0.5 - 20边距
// static Widget divider1HalfPadding20 = const Divider(
//   height: 0.5,
//   thickness: 0.5,
//   indent: 20,
//   endIndent: 20,
//   color: ColorStyle.colorShadow,
// );
//
// ///分割线 0.5 - 无边距
// static Widget divider1Half = const Divider(
//   height: 0.5,
//   thickness: 0.5,
//   color: ColorStyle.colorShadow,
// );
//
// ///分割线 20 - 无边距
// static Widget divider20Half = const Divider(
//   height: 20,
//   thickness: 20,
//   color: ColorStyle.color_F8F9FC,
// );

// Divider hiDivider({
//   BuildContext? context,
//   Color? color,
//   double? size,
// }) =>
//     Icon(
//       Icons.navigate_next,
//       color: color ?? context?.themeData.indicatorColor,
//       size: size ?? 24,
//     );

void removeSystemTransparent(BuildContext context) {
  if (!Platform.isAndroid) {
    return;
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

Widget hiBlur({double? sigma, Widget? child}) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: sigma ?? 10, sigmaY: sigma ?? 10),
    child: Container(
      color: Colors.white10,
      child: child,
    ),
  );
}

Widget hiImage(String url, {double? width, double? height, BoxFit? fit}) {
  if (url.isEmpty) {
    return Container();
  }
  if (url.startsWith('http://') || url.startsWith('https://')) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      placeholder: (BuildContext context, String url) =>
          Container(color: Colors.grey[200]),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          const Icon(Icons.error),
      imageUrl: url,
    );
  }
  Widget? result;
  try {
    result = Image.asset(url, width: width, height: height);
  } catch (e) {
    var value = int.tryParse(url, radix: 16);
    if (value != null) {
      var data = IconData(value, fontFamily: 'MaterialIcons');
      return Icon(data, size: width ?? height);
    }
    result = CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      placeholder: (BuildContext context, String url) =>
          Container(color: Colors.grey[200]),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          const Icon(Icons.error),
      imageUrl: url,
    );
  }
  return result;
}
