import 'package:finding_apartments_yangon/features/data/models/requests/email_otp_verify_request.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/signup_request_with_email.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_otp_verify_response.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';

abstract class AuthDataSource {
  Future<EmailResponse?> signUpWithEmail(SignUpRequestWithEmail body);
  Future<EmailOTPVerifyResponse?> verifyOtpForSignUp(
      EmailOTPVerifyRequest body);
  Future<LoginResponse?> logInWithEmail(LogInRequestWithEmail body);
  bool isAuthenticated();
  Future<EmailResponse?> forgetPassword(String email);
  Future<EmailOTPVerifyResponse?> verifyOtpForForgetPassword(
      EmailOTPVerifyRequest body);
  Future<EmailResponse?> createNewPassword(String newPassword);
}
