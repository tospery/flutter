import 'package:flutter/material.dart';

class HiTabBarItem extends StatelessWidget {
  final String? title;
  final IconData? iconData;

  const HiTabBarItem({
    super.key,
    this.title,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      text: title,
      icon: Icon(iconData),
      iconMargin: const EdgeInsets.all(4),
    );
  }
}
