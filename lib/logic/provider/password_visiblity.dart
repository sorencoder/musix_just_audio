import 'package:flutter/material.dart';

class PasswordVisiblityProvider extends ChangeNotifier {
  bool isvisible = true;
  void setVisiblity() {
    isvisible = !isvisible;
    notifyListeners();
  }
}
