import 'package:hi_core/hi_core.dart';

class HiRouter {
  static final hosts = HiHost();
  static final paths = HiPath();

  // static String urlString(
  //     String host, {
  //       String? path,
  //       Map<String, dynamic>? parameters,
  //     }) {
  //   // var uri = Uri.http('', '', parameters);
  //   var result = '/$host';
  //   if (path?.isNotEmpty ?? false) {
  //     result += '/$path';
  //   }
  //   return result;
  // }
}

class HiHost {
  final splash = 'splash';
  final home = 'home';
  final profile = 'profile';
  final setting = 'setting';
  final about = 'about';
  final search = 'search';
  final user = 'user';
  final tabs = 'tabs';
  final web = 'web';
  final toast = 'toast';
  final alert = 'alert';
  final sheet = 'sheet';
  final popup = 'popup';
  final login = 'login';
}

class HiPath {
  final dashboard = 'dashboard';
  final personal = 'personal';
  final page = 'page';
  final list = 'list';
  final detail = 'detail';
}

String newRouteString ({
  required String host,
  String? path,
  Map<String, dynamic>? parameters,
}) {
  var urlString = '/$host';
  if (path?.isNotEmpty ?? false) {
    urlString += '/$path';
  }
  if (parameters?.isNotEmpty ?? false) {
    urlString += "?";
    parameters?.forEach((key, value) {
      urlString += '$key=$value&';
    });
    urlString = urlString.removeSuffix('&');
  }
  return urlString;
}