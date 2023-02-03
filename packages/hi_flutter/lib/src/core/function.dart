import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../extension/bool.dart';
import '../extension/int.dart';
import '../extension/string.dart';
import 'package:get/get.dart';
import '../view/hi_cached_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool isNotEmpty(String? text) => text?.isNotEmpty ?? false;
bool isEmpty(String? text) => text?.isEmpty ?? true;

bool? hiBool(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any;
  }
  if (any is int) {
    return any.toBool();
  }
  if (any is double) {
    return any.toInt().toBool();
  }
  if (any is String) {
    return any.toBool();
  }
  return null;
}

int? hiInt(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toInt();
  }
  if (any is int) {
    return any;
  }
  if (any is double) {
    return any.toInt();
  }
  if (any is String) {
    return any.toInt();
  }
  return null;
}

double? hiDouble(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toInt().toDouble();
  }
  if (any is int) {
    return any.toDouble();
  }
  if (any is double) {
    return any;
  }
  if (any is String) {
    return any.toDouble();
  }
  return null;
}

String? hiString(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toString();
  }
  if (any is int) {
    return any.toString();
  }
  if (any is double) {
    return any.toString();
  }
  if (any is String) {
    return any;
  }
  return null;
}

Map<String, dynamic>? hiMap(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is Map<String, dynamic>) {
    return any;
  }
  return null;
}

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

Color hiRandomColor() => Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );

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

SizedBox hiSpace({
  double width = 1,
  double height = 1,
}) =>
    SizedBox(
      width: width,
      height: height,
    );

void removeSystemTransparent(BuildContext context) {
  if (!GetPlatform.isAndroid) {
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

Widget hiImage(String url, {double? width, double? height}) {
  if (url.isEmpty) {
    return Container();
  }
  if (url.startsWith('http')) {
    return HiCachedImage(uri: url, width: width, height: height);
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
    result = HiCachedImage(uri: url, width: width, height: height);
  }
  return result;
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

Future<bool?> toast(String message) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
  );
}

showLoading({String? title}) {
}

hideLoading() {
}