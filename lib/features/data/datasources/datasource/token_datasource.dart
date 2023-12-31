import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';

abstract class TokenDataSource {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> saveRefreshToken(String refreshToken);
  String? getRefreshToken();
  Future<void> saveTokenExpireDate(String tokenExpireDate);
  String getTokenExpireDate();
  bool isAuthenticated();
  bool isTokenExpired();
  Future<LoginResponse?> refreshToken();
  Future<void> refreshTokenIfTokenIsExpired();
}
