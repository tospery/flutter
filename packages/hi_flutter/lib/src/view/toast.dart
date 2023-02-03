import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> toast(String message) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
  );
}

showToastActivity({String? title}) {
}

hideToastActivity() {}