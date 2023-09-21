import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  int currentIdx = 0;
  void changePage(int idx) {
    currentIdx = idx;
    notifyListeners();
  }
}
