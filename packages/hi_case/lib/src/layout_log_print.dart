import 'package:flutter/widgets.dart';

/// A helper widget which can print constraints information in debug mode.
class LayoutLogPrint<T> extends StatelessWidget {
  LayoutLogPrint({
    super.key,
    this.show = true,
    this.tag,
    Function(String str)? print,
    required this.child,
  }) : print = print ?? ((str) => debugPrint(str));

  final Widget child;
  final bool show;
  final Function(String str) print;
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        assert(() {
          if (show) {
            print('${tag ?? key ?? child.runtimeType}: $constraints');
          }
          return true;
        }());
        return child;
      },
    );
  }
}
