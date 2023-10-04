abstract class TokenUseCase {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> saveRefreshToken(String refreshToken);
  String? getRefreshToken();
  Future<void> saveTokenExpiredDate(String tokenExpiredDate);
  String? getTokenExpiredDate();
  bool isAuthenticated();
}
