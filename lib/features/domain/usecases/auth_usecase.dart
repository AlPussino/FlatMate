import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/signup_request_with_email.dart';
import '../../data/datasources/auth_datasource.dart';
import '../../data/models/responses/email_otp_verify_response.dart';
import '../../data/models/requests/email_otp_verify_request.dart';
import '../repositories/auth_repository.dart';

abstract class AuthUseCase {
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

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository _authRepository;
  final AuthDataSource _authDataSource;

  AuthUseCaseImpl(this._authRepository, this._authDataSource);

  ///
  @override
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body) async {
    return await _authRepository.signUpWithEmail(body);
  }

  @override
  Future<EmailOTPVerifyResponse?> emailOtpVerification(
      EmailOTPVerifyRequest body) async {
    return await _authRepository.emailOtpVerification(body);
  }

  @override
  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body) async {
    return await _authRepository.logInWithEmail(body);
  }

  @override
  bool isAuthenticated() {
    return _authRepository.isAuthenticated();
  }

  @override
  Future<EmailResponse?> forgetPassword(String email) async {
    return await _authRepository.forgetPassword(email);
  }

  @override
  Future<EmailOTPVerifyResponse?> forgetPasswordOtpVerification(
      EmailOTPVerifyRequest body) async {
    return await _authRepository.forgetPasswordOtpVerification(body);
  }

  @override
  Future<EmailResponse?> createNewPassword(String newPassword) async {
    return await _authRepository.createNewPassword(newPassword);
  }
}
