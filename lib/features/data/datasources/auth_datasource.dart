import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/features/data/datasources/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/noti_pages/notis.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../configs/api_configs.dart';
import '../../../core/utiles.dart';
import '../models/responses/email_otp_verify_response.dart';
import '../models/responses/email_response.dart';
import '../models/requests/email_otp_verify_request.dart';
import '../models/requests/signup_request_with_email.dart';

abstract class AuthDataSource {
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body);
  Future<EmailOTPVerifyResponse?> emailOtpVerification(
      EmailOTPVerifyRequest body);
  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body);
  bool isAuthenticated();
  Future<EmailResponse?> forgetPassword(String email);
  Future<EmailOTPVerifyResponse?> forgetPasswordOtpVerification(
      EmailOTPVerifyRequest body);
  Future<EmailResponse?> createNewPassword(String newPassword);
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
        Notis.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Notis.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Notis.showError('err : $e');
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
        Notis.showSuccess(json.decode(resp.body)['message']);

        return EmailOTPVerifyResponse.fromJson(json.decode(resp.body));
      } else {
        log('this error ${json.decode(resp.body)['message']}');
        Notis.showError(json.decode(resp.body)['message']);
      }
    } on SocketException {
      Notis.showError("Network Error");
      return null;
    } catch (e) {
      log(e.toString());
      Notis.showError('err : $e');
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
        Notis.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Notis.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Notis.showError('err : $e');
      return null;
    }
    return null;
  }

  Future<LoginResponse?> convertHttpRespToLoginResp(http.Response resp) async {
    final loginResp = LoginResponse.fromJson(json.decode(resp.body));
    await _tokenDataSource.saveToken(loginResp.token);
    await _tokenDataSource.saveRefreshToken(loginResp.refreshToken ?? '');
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

  @override
  Future<EmailResponse?> forgetPassword(String email) async {
    try {
      final resp = await _client.post(
        Uri.parse(kForgetPasswordUrl),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          'email': email,
        }),
      );

      if (resp.statusCode == HttpStatus.ok) {
        Notis.showSuccess(json.decode(resp.body)['message']);
        return EmailResponse.fromJson(json.decode(resp.body));
      } else {
        Notis.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Notis.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Notis.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<EmailOTPVerifyResponse?> forgetPasswordOtpVerification(
      EmailOTPVerifyRequest body) async {
    try {
      final resp = await _client.put(Uri.parse(kForgetPasswordOTPVerifyUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (resp.statusCode == HttpStatus.ok) {
        final loginResp = LoginResponse.fromJson(json.decode(resp.body));
        _tokenDataSource.saveToken(loginResp.token);
        return EmailOTPVerifyResponse.fromJson(json.decode(resp.body));
      } else {
        Notis.showError(json.decode(resp.body)['message']);
      }
    } on SocketException {
      Notis.showError("Network Error");
      return null;
    } catch (e) {
      log(e.toString());
      Notis.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<EmailResponse?> createNewPassword(String newPassword) async {
    try {
      final token = _tokenDataSource.getToken();
      final resp = await _client.put(
        Uri.parse(kResetPasswordUrl),
        headers: authHeaders(token: token!),
        body: jsonEncode(<String, dynamic>{
          'password': newPassword,
        }),
      );

      if (resp.statusCode == HttpStatus.ok) {
        Notis.showSuccess(json.decode(resp.body)['message']);
        return EmailResponse.fromJson(json.decode(resp.body));
      } else {
        Notis.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Notis.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Notis.showError('err : $e');
      return null;
    }
    return null;
  }
}
