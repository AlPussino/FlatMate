abstract class TokenDataSource {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> saveRefreshToken(String refreshToken);
  String? getRefreshToken();
  Future<void> saveTokenExpireDate(String tokenExpireDate);
  String getTokenExpireDate();
  bool isAuthenticated();
}
