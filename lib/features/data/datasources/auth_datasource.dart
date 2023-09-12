import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/features/data/datasources/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/reponses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../configs/api_configs.dart';
import '../../../core/utiles.dart';
import '../models/reponses/email_otp_verify_response.dart';
import '../models/reponses/email_response.dart';
import '../models/requests/email_otp_verify_request.dart';
import '../models/requests/signup_request_with_email.dart';

abstract class AuthDataSource {
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body);
  Future<EmailOTPVerifyResponse?> emailOtpVerification(
      EmailOTPVerifyRequest body);
  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body);
  bool isAuthenticated();
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client _client;
  final SharedPreferences pref;
  final TokenDataSource _tokenDataSource;

  AuthDataSourceImpl(this._client, this.pref, this._tokenDataSource);

  ///
  @override
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body) async {
    try {
      final resp = await _client.post(Uri.parse(kSignUpUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (resp.statusCode == HttpStatus.ok) {
        return EmailResponse.fromJson(json.decode(resp.body));
      } else {
        Utils.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Utils.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<EmailOTPVerifyResponse?> emailOtpVerification(
      EmailOTPVerifyRequest body) async {
    try {
      final resp = await _client.put(Uri.parse(kEmailOTPVerifyUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (resp.statusCode == HttpStatus.ok) {
        return EmailOTPVerifyResponse.fromJson(json.decode(resp.body));
      } else {
        log('this error ${json.decode(resp.body)['message']}');
        Utils.showError(json.decode(resp.body)['message']);
      }
    } on SocketException {
      Utils.showError("Network Error");
      return null;
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body) async {
    try {
      final resp = await _client.post(Uri.parse(kLogInUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (resp.statusCode == HttpStatus.ok) {
        return convertHttpRespToLoginResp(resp);
      } else {
        Utils.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Utils.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  Future<LoginResponse?> convertHttpRespToLoginResp(http.Response resp) async {
    final loginResp = LoginResponse.fromJson(json.decode(resp.body));
    await _tokenDataSource.saveToken(loginResp.token);
    await _tokenDataSource.saveRefreshToken(loginResp.refreshToken);
    await _tokenDataSource.saveTokenExpireDate(loginResp.expiration.toString());
    log("This is token : ${loginResp.token}");
    log("This is refreshToken : ${loginResp.refreshToken}");
    log("This is token expiredDate : ${loginResp.expiration}");
    log("Current Time : ${DateTime.now()}");
    return loginResp;
  }

  @override
  bool isAuthenticated() {
    return _tokenDataSource.isAuthenticated();
  }
}
