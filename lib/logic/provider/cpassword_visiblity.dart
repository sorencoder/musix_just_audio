import 'package:flutter/material.dart';

class CpasswordVisiblity extends ChangeNotifier {
  bool isvisible = true;
  void setVisiblity() {
    isvisible = !isvisible;
    notifyListeners();
  }
}
