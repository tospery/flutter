import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hi_core/hi_core.dart';

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
      color: color ?? context?.themeData.indicatorColor,
      size: size ?? 24,
    );

SizedBox hiSpace({
  double width = 1,
  double height = 1,
}) =>
    SizedBox(
      width: width,
      height: height,
    );

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