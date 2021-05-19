import 'package:flutter/foundation.dart';

class PeopleModel extends ChangeNotifier {
  bool lightMode = true;

  void setIsLightMode(bool lightMode) {
    this.lightMode = lightMode;
    notifyListeners();
  }
}
