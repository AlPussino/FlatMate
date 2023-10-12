import 'dart:developer';

import 'package:flutter/material.dart';

class EditPostProvider with ChangeNotifier {
  int? _leftTenants;
  int? get leftTenants => _leftTenants;

  void editTenants(int tenantsAmount) {
    _leftTenants = tenantsAmount;

    log(leftTenants.toString());
    notifyListeners();
  }

  void restartEditPostProvider() {
    _leftTenants = null;
  }
}
