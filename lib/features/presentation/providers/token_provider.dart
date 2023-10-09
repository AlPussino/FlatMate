import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:flutter/material.dart';

class TokenProvider with ChangeNotifier {
  final TokenDataSource _tokenDataSource;

  TokenProvider(this._tokenDataSource);

  // bool isTokenExpired() {
  //   try {
  //     String tokenExpireDate = _tokenDataSource.getTokenExpireDate();
  //     DateTime expirationDateTime = DateTime.parse(tokenExpireDate);
  //     DateTime currentDateTime = DateTime.now().toUtc();
  //     log("Token expired => ${expirationDateTime.isBefore(currentDateTime)}");
  //     log("Cur time : $currentDateTime");
  //     log("Exp time : $expirationDateTime");
  //     return expirationDateTime.isBefore(currentDateTime);
  //   } catch (e) {
  //     return true;
  //   }
  // }

  bool isTokenExpired() {
    final data = _tokenDataSource.isTokenExpired();
    return data;
  }
}
