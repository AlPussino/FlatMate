import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../data/models/divisions_and_townships.dart';

class HomeProvider with ChangeNotifier {
  int currentIdx = 0;
  void changePage(int idx) {
    currentIdx = idx;
    notifyListeners();
  }
}
