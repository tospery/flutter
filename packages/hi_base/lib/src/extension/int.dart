import 'dart:math' as Math;

extension IntHiBaseEx on int {
  bool toBool() => this != 0;

  String formatBytes({int decimals = 0}) {
    if (this <= 0) return '0';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = (Math.log(this) / Math.log(1024)).floor();
    final fixed = i <= 1 ? 0 : decimals;
    return ((this / Math.pow(1024, i)).toStringAsFixed(fixed)) +
        ' ' +
        suffixes[i];
  }
}
