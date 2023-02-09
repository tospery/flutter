import 'dart:math';
import 'package:flutter/material.dart';

extension ColorsEx on Colors {

  static Color get random => Color.fromRGBO(
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
    1,
  );

}