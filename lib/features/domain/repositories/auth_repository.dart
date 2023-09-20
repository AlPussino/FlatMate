import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/signup_request_with_email.dart';

import '../../data/models/responses/email_otp_verify_response.dart';
import '../../data/models/responses/email_response.dart';
import '../../data/models/requests/email_otp_verify_request.dart';

abstract class AuthRepository {
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
