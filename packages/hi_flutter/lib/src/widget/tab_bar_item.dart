import 'package:flutter/material.dart';

class HiTabBarItem extends StatelessWidget {
  final String? title;
  final Widget? image;

  const HiTabBarItem({
    super.key,
    this.title,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      text: title,
      icon: image,
      iconMargin: const EdgeInsets.all(4),
    );
  }
}
