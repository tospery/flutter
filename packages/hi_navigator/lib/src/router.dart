import 'package:hi_core/hi_core.dart';

class HiRouter {
  static final hosts = HiHost();
  static final paths = HiPath();

  static String urlString() {
    return "";
  }
}

class HiHost {
  final splash = 'splash';
  final home = 'home';
  final profile = 'profile';
  final settings = 'settings';
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