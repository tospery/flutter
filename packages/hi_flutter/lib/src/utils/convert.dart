import '../extension/string.dart';

class HiConvert {
  static String toJsonString(String string) => string.toJsonString();
  // static Map<String, dynamic> toJsonObject(String string) =>
  //     string.toJsonObject();
  // static List<dynamic> toJsonArray(String string) => string.toJsonArray();
  static dynamic toJson(String string) => string.toJson();
}
