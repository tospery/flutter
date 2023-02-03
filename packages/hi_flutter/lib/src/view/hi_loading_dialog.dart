import 'package:flutter/material.dart';
import 'package:hi_flutter/src/resource/r.dart';
import 'package:lottie/lottie.dart';

class HiLoadingDialog extends StatelessWidget {
  final String? title;

  const HiLoadingDialog({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Container(
            decoration: const ShapeDecoration(
              color: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    R.assets.animation.loading,
                    width: 60,
                    animate: true,
                  ),
                ),
                Text(
                  title ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
