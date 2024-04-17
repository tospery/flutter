import 'package:flutter/material.dart';
import 'over_scroll_behavior.dart';

class HiPopupView extends StatefulWidget {
  final double shape;
  final double horizontal;
  final Widget child;

  HiPopupView({
    super.key,
    this.shape = 10,
    this.horizontal = 25,
    required this.child,
  });

  @override
  State<HiPopupView> createState() => _BaseDialogState();
}

class _BaseDialogState extends State<HiPopupView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    // animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //   parent: animationController!,
    //   curve: Curves.easeIn,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    animationController?.forward();
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: ScrollConfiguration(
          behavior: HiOverScrollBehavior(),
          child: ScaleTransition(
            alignment: Alignment.center,
            scale: animationController!,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: widget.horizontal),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.shape),
                    child: widget.child,
                  ),
                  // child: Container(
                  //   decoration: ShapeDecoration(
                  //     color: Colors.green,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(widget.shape),
                  //       ),
                  //     ),
                  //   ),
                  //   child: widget.child,
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }
}
