import 'dart:convert';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/api_configs.dart';
import 'package:finding_apartments_yangon/features/data/datasources/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/reponses/login_response.dart';
import 'package:http/http.dart' as http;
import '../../../core/utiles.dart';
import '../models/my_user.dart';

abstract class UserDataSource {
  Future<MyUser?> getUserInfo();
  Future<MyUser?> refreshToken(Function call);
}

class UserDataSourceImpl implements UserDataSource {
  final http.Client _client;
  final TokenDataSource _tokenDataSource;

  UserDataSourceImpl(this._client, this._tokenDataSource);

  @override
  Future<MyUser?> getUserInfo() async {
    final token = _tokenDataSource.getToken();
    final resp = await _client.get(Uri.parse(kAboutMeUrl),
        headers: authHeaders(token: token!));

    if (resp.statusCode == HttpStatus.ok) {
      return MyUser.fromJson(json.decode(resp.body));
      // return null;
    } else if (resp.statusCode == HttpStatus.unauthorized) {
      final user = await refreshToken(getUserInfo);

      if (user != null) {
        return user;
      } else {
        return null;
      }
    } else {
      throw Exception(resp.body);
    }
  }

  @override
  Future<MyUser?> refreshToken(Function call) async {
    final refreshToken = _tokenDataSource.getRefreshToken();
    final resp = await _client.get(
      Uri.parse("$kRefreshTokenUrl$refreshToken"),
    );

    if (resp.statusCode == HttpStatus.ok) {
      final loginResp = LoginResponse.fromJson(json.decode(resp.body));
      await _tokenDataSource.saveToken(loginResp.token);
      await _tokenDataSource.saveRefreshToken(loginResp.refreshToken);
      await _tokenDataSource
          .saveTokenExpireDate(loginResp.expiration.toString());
      final MyUser user = await call();
      return user;
    } else if (resp.statusCode == HttpStatus.badRequest) {
      throw Exception(
          'You need to login again because your device has changed.');
    }
    return null;
  }
}
