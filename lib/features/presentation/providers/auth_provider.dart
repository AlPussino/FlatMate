import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:flutter/material.dart';
import '../../data/datasources/token_datasource.dart';
import '../../data/models/responses/email_otp_verify_response.dart';
import '../../data/models/responses/email_response.dart';
import '../../data/models/requests/email_otp_verify_request.dart';
import '../../data/models/requests/signup_request_with_email.dart';
import '../../domain/usecases/auth_usecase.dart';

class AuthProvider with ChangeNotifier {
  final AuthUseCase _authUseCase;
  final TokenDataSource _tokenDataSource;
  AuthProvider(this._authUseCase, this._tokenDataSource);

  Future<EmailResponse?> signUpWithEmail(
      {required SignUpRequestWithEmail body}) async {
    return await _authUseCase.signUpWithEmail(body);
  }

  Future<EmailOTPVerifyResponse?> emailOtpVerification(
      {required EmailOTPVerifyRequest body}) async {
    return await _authUseCase.emailOtpVerification(body);
  }

  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body) async {
    return await _authUseCase.logInWithEmail(body);
  }

  bool isAuthenticated() {
    notifyListeners();
    return _authUseCase.isAuthenticated();
  }

  bool isTokenExpired() {
    try {
      String tokenExpireDate = _tokenDataSource.getTokenExpireDate();
      DateTime expirationDateTime = DateTime.parse(tokenExpireDate);
      DateTime currentDateTime = DateTime.now();
      return currentDateTime.isAfter(expirationDateTime);
    } catch (e) {
      return true;
    }
  }

  Future<EmailResponse?> forgetPassword(String email) async {
    return await _authUseCase.forgetPassword(email);
  }

  Future<EmailOTPVerifyResponse?> forgetPasswordOtpVerification(
      {required EmailOTPVerifyRequest body}) async {
    return _authUseCase.forgetPasswordOtpVerification(body);
  }

  Future<EmailResponse?> createNewPassword(String newPassword) async {
    return await _authUseCase.createNewPassword(newPassword);
  }
}
