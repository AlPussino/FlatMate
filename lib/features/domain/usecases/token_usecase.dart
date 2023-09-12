import '../repositories/token_repository.dart';

abstract class TokenUseCase {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> saveRefreshToken(String refreshToken);
  String? getRefreshToken();
  Future<void> saveTokenExpiredDate(String tokenExpiredDate);
  String? getTokenExpiredDate();
  bool isAuthenticated();
}

class TokenUseCaseImpl implements TokenUseCase {
  final TokenRepository tokenRepository;

  TokenUseCaseImpl(this.tokenRepository);

  @override
  Future<void> saveToken(String token) async {
    return await tokenRepository.saveToken(token);
  }

  @override
  String? getToken() {
    return tokenRepository.getToken();
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    return await tokenRepository.saveRefreshToken(refreshToken);
  }

  @override
  String? getRefreshToken() {
    return tokenRepository.getRefreshToken();
  }

  @override
  Future<void> saveTokenExpiredDate(String tokenExpiredDate) async {
    return await tokenRepository.saveTokenExpiredDate(tokenExpiredDate);
  }

  @override
  String? getTokenExpiredDate() {
    return tokenRepository.getTokenExpiredDate();
  }

  @override
  bool isAuthenticated() {
    return tokenRepository.isAuthenticated();
  }
}
