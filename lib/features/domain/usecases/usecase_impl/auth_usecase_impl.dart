import 'package:finding_apartments_yangon/features/data/models/requests/email_otp_verify_request.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/signup_request_with_email.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_otp_verify_response.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/auth_repository.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/auth_usecase.dart';

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCaseImpl(this._authRepository);

  ///
  @override
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body) async {
    return await _authRepository.signUpWithEmail(body);
  }

  @override
  Future<EmailOTPVerifyResponse?> verifyOtpForSignUp(
      EmailOTPVerifyRequest body) async {
    return await _authRepository.verifyOtpForSignUp(body);
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
  Future<EmailOTPVerifyResponse?> verifyOtpForForgetPassword(
      EmailOTPVerifyRequest body) async {
    return await _authRepository.verifyOtpForForgetPassword(body);
  }

  @override
  Future<EmailResponse?> createNewPassword(String newPassword) async {
    return await _authRepository.createNewPassword(newPassword);
  }
}
