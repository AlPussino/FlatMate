import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/api_configs.dart';
import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:finding_apartments_yangon/core/utiles.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/auth_datasource.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/email_otp_verify_request.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/signup_request_with_email.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_otp_verify_response.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/notification_pages/toast_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;
  final SharedPreferences pref;
  final TokenDataSource tokenDataSource;

  AuthDataSourceImpl(this.client, this.pref, this.tokenDataSource);

  ///
  @override
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body) async {
    try {
      final response = await client.post(Uri.parse(signUpUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (response.statusCode == HttpStatus.ok) {
        return EmailResponse.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
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

  @override
  Future<EmailOTPVerifyResponse?> verifyOtpForSignUp(
      EmailOTPVerifyRequest body) async {
    try {
      final response = await client.put(Uri.parse(emailOTPVerifyUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess(json.decode(response.body)['message']);

        return EmailOTPVerifyResponse.fromJson(json.decode(response.body));
      } else {
        log('this error ${json.decode(response.body)['message']}');
        ToastNotificatoins.showError(json.decode(response.body)['message']);
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

  @override
  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body) async {
    try {
      final response = await client.post(Uri.parse(logInUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (response.statusCode == HttpStatus.ok) {
        return convertHttpRespToLoginResp(response);
      } else {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
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
    await tokenDataSource.saveToken(loginResponse.token);
    await tokenDataSource.saveRefreshToken(loginResponse.refreshToken ?? '');
    await tokenDataSource
        .saveTokenExpireDate(loginResponse.expiration.toString());
    log("This is token : ${loginResponse.token}");
    log("This is refreshToken : ${loginResponse.refreshToken}");
    log("This is token expiredDate : ${loginResponse.expiration}");
    log("Current Time : ${DateTime.now()}");
    return loginResponse;
  }

  @override
  bool isAuthenticated() {
    return tokenDataSource.isAuthenticated();
  }

  @override
  Future<EmailResponse?> forgetPassword(String email) async {
    try {
      final response = await client.post(
        Uri.parse(forgetPasswordUrl),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          'email': email,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess(json.decode(response.body)['message']);
        return EmailResponse.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
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

  @override
  Future<EmailOTPVerifyResponse?> verifyOtpForForgetPassword(
      EmailOTPVerifyRequest body) async {
    try {
      final response = await client.put(Uri.parse(forgetPasswordOTPVerifyUrl),
          headers: headers, body: json.encode(body.toJson()));

      if (response.statusCode == HttpStatus.ok) {
        final loginResp = LoginResponse.fromJson(json.decode(response.body));
        tokenDataSource.saveToken(loginResp.token);
        return EmailOTPVerifyResponse.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
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

  @override
  Future<EmailResponse?> createNewPassword(String newPassword) async {
    try {
      final token = tokenDataSource.getToken();
      final response = await client.put(
        Uri.parse(resetPasswordUrl),
        headers: authHeaders(token: token!),
        body: jsonEncode(<String, dynamic>{
          'password': newPassword,
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess(json.decode(response.body)['message']);
        return EmailResponse.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
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
}
