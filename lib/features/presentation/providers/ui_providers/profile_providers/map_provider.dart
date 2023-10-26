import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapProvider with ChangeNotifier {
  double _currentLatitude = 0;
  double get currentLatitude => _currentLatitude;

  double _currentLongitude = 0;
  double get currentLongitude => _currentLongitude;

  bool _isStreetStyle = true;
  bool get isStreetStyle => _isStreetStyle;

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    log("Position : ${position.latitude} , ${position.longitude}");
    _currentLatitude = position.latitude;
    _currentLongitude = position.longitude;
    notifyListeners();
  }

  void changeMapStyle() {
    isStreetStyle == true ? _isStreetStyle = false : _isStreetStyle = true;
    notifyListeners();
  }
}
