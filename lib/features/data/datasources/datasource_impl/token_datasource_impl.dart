import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/api_configs.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/notification_pages/toast_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenDataSourceImpl implements TokenDataSource {
  final http.Client client;
  final SharedPreferences pref;

  TokenDataSourceImpl(this.client, this.pref);
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

  @override
  bool isTokenExpired() {
    try {
      String tokenExpiredDate = getTokenExpireDate();
      DateTime expirationDateTime = DateTime.parse(tokenExpiredDate);
      DateTime currentDateTime = DateTime.now().toUtc();
      log("Token is expired : ${expirationDateTime.isBefore(currentDateTime)}");
      log("Expired Date : $expirationDateTime");
      log("Current Data : $currentDateTime");
      return expirationDateTime.isBefore(currentDateTime);
    } catch (e) {
      return true;
    }
  }

  @override
  Future<LoginResponse?> refreshToken() async {
    final refreshToken = getRefreshToken();
    try {
      final response = await client.get(
        Uri.parse("$refreshTokenUrl$refreshToken"),
      );

      if (response.statusCode == HttpStatus.ok) {
        log("refresh toke ok");
        return convertHttpRespToLoginResp(response);
      } else if (response.statusCode == HttpStatus.badRequest) {
        log('bad request error');
        return null;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        log('Unauthorize error');
        return null;
      } else if (response.statusCode == HttpStatus.notFound) {
        log('Token not found error');
        return null;
      } else {
        ToastNotificatoins.showError('refreshing token error');
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  Future<LoginResponse?> convertHttpRespToLoginResp(http.Response resp) async {
    final loginResponse = LoginResponse.fromJson(json.decode(resp.body));
    await saveToken(loginResponse.token);
    await saveRefreshToken(loginResponse.refreshToken!);
    await saveTokenExpireDate(loginResponse.expiration.toString());
    log("This is token : ${loginResponse.token}");
    log("This is refreshToken : ${loginResponse.refreshToken}");
    log("This is token expiredDate : ${loginResponse.expiration}");
    log("Current Time : ${DateTime.now()}");
    return loginResponse;
  }

  Future<void> refreshTokenIfTokenIsExpired() async {
    final expiredResult = isTokenExpired();
    if (expiredResult == true) {
      final refreshResult = await refreshToken();

      if (refreshResult != null) {
        log("success refresh token");
      } else {
        log("fail refresh token");
      }
    } else {
      null;
    }
  }
}
