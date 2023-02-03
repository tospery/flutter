import 'package:flutter/material.dart';
import '../core/function.dart';
import '../model/hi_model.dart';

typedef HiCellPressed<M extends HiModel> = void Function(M model,
    {dynamic extra});

class HiCell<M extends HiModel> extends StatelessWidget {
  final M model;
  final HiCellPressed<M>? onPressed;

  get updateId => null;

  const HiCell({
    super.key,
    required this.model,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed != null ? onPressed!(model) : null,
      child: Container(
        height: 50,
        color: hiRandomColor(),
      ),
    );
  }
}
