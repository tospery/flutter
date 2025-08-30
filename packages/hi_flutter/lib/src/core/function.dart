import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:hi_flutter/src/core/constant.dart';
import 'package:hi_flutter/src/model/tile.dart';

EdgeInsets get safeArea {
  final context = Get.context ?? Get.overlayContext;
  if (context == null) {
    return EdgeInsets.zero;
  }
  return context.mediaQueryPadding;
}

HiTile? tryTile(dynamic data) {
  if (data == null || data is! HiTile) {
    return null;
  }
  return data as HiTile? ?? null;
}

Future<bool> storeObject<M extends HiModel>(
  M model, {
  String? id,
  bool? isReactive,
  bool? needReload,
}) async {
  await HiCache.shared().storeObject(model, id: id);
  if (isReactive ?? false) {
    if (model is HiUser) {
      Get.replace<HiUser>(model);
    }
    if (model is HiProfile) {
      Get.replace<HiProfile>(model);
    }
  }
  eventBus.fire({
    HiParameter.model: model,
    HiParameter.needReload: needReload,
  }); // YJX_TODO 检查是否合理
  return true;
}

Future<M?> fetchObject<M extends HiModel>(
  M Function(dynamic) fromJson, {
  String? id,
}) =>
    HiCache.shared().fetchObject(fromJson, id: id);

Future<bool> storeArray<M extends HiModel>(
  List<M> models, {
  String? page,
}) =>
    HiCache.shared().storeArray(models, page: page);

Future<List<M>> fetchArray<M extends HiModel>(
  M Function(dynamic) fromJson, {
  String? page,
}) =>
    HiCache.shared().fetchArray(fromJson, page: page);

double metricWidth(
  double width, {
  BuildContext? context,
}) {
  final designWidth = 393.0;
  var deviceWidth =
      (context ?? Get.context ?? Get.overlayContext)?.width ?? designWidth;
  return width / designWidth * deviceWidth;
}

double metricHeight(
  double height, {
  BuildContext? context,
}) {
  final designHeight = 852.0;
  var deviceHeight =
      (context ?? Get.context ?? Get.overlayContext)?.width ?? designHeight;
  return height / designHeight * deviceHeight;
}

double pixelOne({BuildContext? context}) {
  final ctx = context ?? Get.overlayContext;
  if (ctx == null) {
    return 1;
  }
  return 1 / MediaQuery.of(ctx).devicePixelRatio;
}

SizedBox newBox({double? width, double? height}) =>
    SizedBox(width: width, height: height);

ClipRRect newRoundedRect({double? radius, Widget? child}) => ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: SizedBox(
        width: (radius ?? 0) * 2,
        height: (radius ?? 0) * 2,
        child: child,
      ),
    );

Border newBorder({
  BuildContext? context,
  Color? color,
  double? width,
  bool? top,
  bool? right,
  bool? bottom,
  bool? left,
}) {
  final borderSide = Divider.createBorderSide(
    context,
    width: width,
    color: color,
  );
  return Border(
    top: top ?? false ? borderSide : BorderSide.none,
    right: right ?? false ? borderSide : BorderSide.none,
    bottom: bottom ?? false ? borderSide : BorderSide.none,
    left: left ?? false ? borderSide : BorderSide.none,
  );
}

UnderlineInputBorder newUnderlineBorder({
  BuildContext? context,
  double? width,
  Color? color,
}) =>
    UnderlineInputBorder(
      borderSide: Divider.createBorderSide(
        context,
        width: width ?? context?.theme.dividerTheme.thickness,
        color: color ?? context?.theme.dividerTheme.color,
      ),
      borderRadius: BorderRadius.zero,
    );

OutlineInputBorder newOutlineBorder({
  Color? color,
  double? width = 1.0,
  double radius = 4.0,
  BuildContext? context,
}) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: Divider.createBorderSide(
        context,
        width: width,
        color:
            color ?? (context ?? Get.overlayContext)?.theme.dividerTheme.color,
      ),
    );

BoxDecoration newShadowDecoration({
  Color? color = Colors.white,
  double radius = 10,
}) =>
    BoxDecoration(
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

Icon newIndicator({
  BuildContext? context,
  Color? color,
  double? size = 24,
}) =>
    Icon(
      Icons.navigate_next,
      color: color ?? context?.theme.tabBarTheme.indicatorColor,
      size: size,
    );

Widget newBlur({double sigma = 10, Widget? child}) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: Colors.white10,
        child: child,
      ),
    );

Widget newImageWidget(
  String url, {
  double? width,
  double? height,
  double? radius,
  BoxFit? fit,
  Color? blendedColor,
  Color? placeholderColor,
  Image? placeholder,
  BuildContext? context,
}) {
  if (url.isEmpty) {
    return Container();
  }
  if (url.isValidHttpUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: fit,
        placeholder: (BuildContext context, String url) {
          if (placeholder == null) {
            return Container(
              width: width,
              height: height,
              color: placeholderColor != null
                  ? placeholderColor
                  : context.theme.highlightColor,
            );
          }
          return SizedBox(
            width: width,
            height: height,
            child: placeholder,
          );
        },
        errorWidget: (BuildContext context, String url, dynamic error) =>
            const Icon(Icons.error),
        imageUrl: url,
      ),
    );
  }
  Widget? result;
  try {
    result = Image.asset(
      url,
      width: width,
      height: height,
      color: blendedColor,
    );
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

ImageProvider? newImageProvider(String url) {
  if (url.isEmpty) {
    return null;
  }
  if (url.isValidHttpUrl) {
    return NetworkImage(url);
  }
  try {
    return AssetImage(url);
  } catch (e) {
    return null;
  }
}

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
