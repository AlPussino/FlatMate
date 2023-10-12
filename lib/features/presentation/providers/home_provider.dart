import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int currentIdx = 0;
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  void changePage(int idx) {
    currentIdx = idx;
    notifyListeners();
  }

  void scrollUpToTheStart() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void saveController(ScrollController controller) {
    _scrollController = controller;
  }

  bool isListAtTop() {
    return _scrollController.position.atEdge ? true : false;
  }
}
