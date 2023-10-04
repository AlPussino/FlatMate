import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/auth_usecase.dart';
import 'package:flutter/material.dart';
import '../../data/models/responses/email_otp_verify_response.dart';
import '../../data/models/responses/email_response.dart';
import '../../data/models/requests/email_otp_verify_request.dart';
import '../../data/models/requests/signup_request_with_email.dart';

class AuthProvider with ChangeNotifier {
  final AuthUseCase _authUseCase;
  AuthProvider(this._authUseCase);

  Future<EmailResponse?> signUpWithEmail(
      {required SignUpRequestWithEmail body}) async {
    return await _authUseCase.signUpWithEmail(body);
  }

  Future<EmailOTPVerifyResponse?> verifyOtpForSignUp(
      {required EmailOTPVerifyRequest body}) async {
    return await _authUseCase.verifyOtpForSignUp(body);
  }

  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body) async {
    return await _authUseCase.logInWithEmail(body);
  }

  bool isAuthenticated() {
    notifyListeners();
    return _authUseCase.isAuthenticated();
  }

  Future<EmailResponse?> forgetPassword(String email) async {
    return await _authUseCase.forgetPassword(email);
  }

  Future<EmailOTPVerifyResponse?> verifyOtpForForgetPassword(
      {required EmailOTPVerifyRequest body}) async {
    return _authUseCase.verifyOtpForForgetPassword(body);
  }

  Future<EmailResponse?> createNewPassword(String newPassword) async {
    return await _authUseCase.createNewPassword(newPassword);
  }
}
