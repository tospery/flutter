class HiRouter {
  static final hosts = HiHost();
  static final paths = HiPath();

  static String urlString(
      String host, {
        String? path,
        Map<String, dynamic>? parameters,
      }) {
    // var uri = Uri.http('', '', parameters);
    var result = '/$host';
    if (path?.isNotEmpty ?? false) {
      result += '/$path';
    }
    return result;
  }
}

class HiHost {
  final splash = 'splash';
  final home = 'home';
  final dashboard = 'dashboard';
  final personal = 'personal';
  final profile = 'profile';
  final settings = 'settings';
  final about = 'about';
  final search = 'search';
  final login = 'login';
  final user = 'user';
  final toast = 'toast';
  final alert = 'alert';
  final sheet = 'sheet';
  final popup = 'popup';
}

class HiPath {
  final page = 'page';
  final list = 'list';
  final detail = 'detail';
}