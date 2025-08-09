import 'package:hi_base/hi_base.dart';

class HiConvert {
  static String toJsonString(String string) => string.toJsonString();
  static dynamic toJson(String string) => string.toJson();
  static Map<String, dynamic>? toJsonObject(String string) =>
      string.toJsonObject();
  static List<dynamic>? toJsonArray(String string) => string.toJsonArray();
}
