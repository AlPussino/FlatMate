import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenDataSourceImpl implements TokenDataSource {
  final SharedPreferences pref;

  TokenDataSourceImpl(this.pref);
  @override
  Future<void> saveToken(String token) async {
    await pref.setString(AppString.tokenKey, token);
  }

  @override
  String? getToken() {
    return pref.getString(AppString.tokenKey);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await pref.setString(AppString.refreshTokenKey, refreshToken);
  }

  @override
  String? getRefreshToken() {
    return pref.getString(AppString.refreshTokenKey);
  }

  @override
  Future<void> saveTokenExpireDate(String tokenExpireDate) async {
    await pref.setString(AppString.tokenExpiredDate, tokenExpireDate);
  }

  @override
  String getTokenExpireDate() {
    return pref.getString(AppString.tokenExpiredDate) ?? '';
  }

  @override
  bool isAuthenticated() {
    final token = getToken();
    return token != null;
  }
}
