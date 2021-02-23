import 'package:flutter/foundation.dart';

class SelectController extends ChangeNotifier {
  int count = 0;

  void addCount() {
    count = count + 1;
    notifyListeners();
  }
}