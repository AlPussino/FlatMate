import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';

class TokenProvider with ChangeNotifier {
  final TokenDataSource _tokenDataSource;

  TokenProvider(this._tokenDataSource);

  bool isTokenExpired() {
    final data = _tokenDataSource.isTokenExpired();
    return data;
  }

  Future<String> getDeviceId() async {
    String deviceId = await FlutterUdid.udid;
    return deviceId;
  }
}
