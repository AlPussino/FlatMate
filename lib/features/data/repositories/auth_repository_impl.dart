import 'package:finding_apartments_yangon/features/data/datasources/auth_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/signup_request_with_email.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/auth_repository.dart';
import '../models/responses/email_otp_verify_response.dart';
import '../models/responses/email_response.dart';
import '../models/requests/email_otp_verify_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body) async {
    return await _authDataSource.signUpWithEmail(body);
  }

  @override
  Future<EmailOTPVerifyResponse?> emailOtpVerification(
      EmailOTPVerifyRequest body) async {
    return await _authDataSource.emailOtpVerification(body);
  }

  @override
  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body) async {
    return await _authDataSource.logInWithEmail(body);
  }

  @override
  bool isAuthenticated() {
    return _authDataSource.isAuthenticated();
  }

  @override
  Future<EmailResponse?> forgetPassword(String email) async {
    return await _authDataSource.forgetPassword(email);
  }

  @override
  Future<EmailOTPVerifyResponse?> forgetPasswordOtpVerification(
      EmailOTPVerifyRequest body) async {
    return await _authDataSource.forgetPasswordOtpVerification(body);
  }

  @override
  Future<EmailResponse?> createNewPassword(String newPassword) async {
    return await _authDataSource.createNewPassword(newPassword);
  }
}
