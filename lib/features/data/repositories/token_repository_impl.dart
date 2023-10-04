import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import '../../domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenDataSource tokenDataSource;

  TokenRepositoryImpl(this.tokenDataSource);

  @override
  Future<void> saveToken(String token) {
    return tokenDataSource.saveToken(token);
  }

  @override
  String? getToken() {
    return tokenDataSource.getToken();
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) {
    return tokenDataSource.saveRefreshToken(refreshToken);
  }

  @override
  String? getRefreshToken() {
    return tokenDataSource.getRefreshToken();
  }

  @override
  Future<void> saveTokenExpiredDate(String tokenExpiredDate) {
    return tokenDataSource.saveTokenExpireDate(tokenExpiredDate);
  }

  @override
  String? getTokenExpiredDate() {
    return tokenDataSource.getTokenExpireDate();
  }

  @override
  bool isAuthenticated() {
    return tokenDataSource.isAuthenticated();
  }
}
