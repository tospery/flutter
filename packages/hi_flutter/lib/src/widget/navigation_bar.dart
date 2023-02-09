import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HiNavigationBar extends StatefulWidget {
  final bool isShowEnd;
  final String? title;
  final String? endText;
  final Color? backgroundColor;
  final Color? backColor;
  final VoidCallback? backOnTap;

  const HiNavigationBar({
    super.key,
    this.isShowEnd = false,
    this.title,
    this.endText,
    this.backgroundColor = Colors.white,
    this.backColor = const Color(0xFFB8C0D4),
    this.backOnTap,
  });

  @override
  State<HiNavigationBar> createState() => _HiNavigationBarState();
}

class _HiNavigationBarState extends State<HiNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      child: SafeArea(
        top: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBack(),
            _buildTitle(),
            _buildRight(),
          ],
        ),
      ),
    );
  }

  _buildBack() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 6, left: 15),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        onTap: widget.backOnTap ?? () => Get.back(),
        splashColor: const Color(0x66E2E3E8),
        highlightColor: const Color(0x66E2E3E8),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Icon(
            Icons.arrow_back,
            color: widget.backColor,
          ),
        ),
      ),
    );
  }

  _buildTitle() {
    return Container(
      width: 150,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5, right: 12),
      child: Text(
        widget.title ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }

  _buildRight() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        widget.endText ?? '',
        style: const TextStyle(color: Color(0xFFB8C0D4), fontSize: 13),
      ),
    );
  }
}
