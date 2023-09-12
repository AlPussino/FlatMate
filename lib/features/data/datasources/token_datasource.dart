import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenDataSource {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> saveRefreshToken(String refreshToken);
  String? getRefreshToken();
  Future<void> saveTokenExpireDate(String tokenExpireDate);
  String getTokenExpireDate();
  bool isAuthenticated();
}

class TokenDataSourceImpl implements TokenDataSource {
  final SharedPreferences pref;

  TokenDataSourceImpl(this.pref);
  @override
  Future<void> saveToken(String token) async {
    await pref.setString(kTokenKey, token);
  }

  @override
  String? getToken() {
    return pref.getString(kTokenKey);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await pref.setString(kRefreshTokenKey, refreshToken);
  }

  @override
  String? getRefreshToken() {
    return pref.getString(kRefreshTokenKey);
  }

  @override
  Future<void> saveTokenExpireDate(String tokenExpireDate) async {
    await pref.setString(kTokenExpiredDate, tokenExpireDate);
  }

  @override
  String getTokenExpireDate() {
    return pref.getString(kTokenExpiredDate) ?? '';
  }

  @override
  bool isAuthenticated() {
    final token = getToken();
    return token != null;
  }
}
