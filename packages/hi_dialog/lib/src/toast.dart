import 'package:fluttertoast/fluttertoast.dart';

toast(String message) {
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