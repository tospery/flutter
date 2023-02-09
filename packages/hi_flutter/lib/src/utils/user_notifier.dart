import 'package:flutter/material.dart';

class HiUserNotifier extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}
