import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/auth_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/sign_up_providers/sign_up_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/create_new_password_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../data/models/requests/email_otp_verify_request.dart';
import '../../../data/models/requests/signup_request_with_email.dart';

class EmailOTPVerificationPage extends StatefulWidget {
  final SignUpRequestWithEmail loginReqWithEmail;
  final bool isReset;
  const EmailOTPVerificationPage(
      {super.key, required this.loginReqWithEmail, required this.isReset});

  @override
  State<EmailOTPVerificationPage> createState() =>
      _EmailOTPVerificationPageState();
}

class _EmailOTPVerificationPageState extends State<EmailOTPVerificationPage> {
  String verificationCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  "Email verification",
                  style: TextStyle(
                    color: AppColor.orangeColor,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "A verification code has been sent to ${widget.loginReqWithEmail.email}",
                  style: TextStyle(
                    color: AppColor.greyColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: VerificationCode(
                underlineWidth: 1,
                underlineUnfocusedColor: const Color(0xffB0B0B0),
                underlineColor: AppColor.orangeColor,
                keyboardType: TextInputType.number,
                length: 6,
                autofocus: true,
                onCompleted: (String value) {
                  setState(() {
                    verificationCode = value;
                  });
                },
                onEditing: (bool value) {},
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final result = widget.isReset
                    ? await context
                        .read<AuthProvider>()
                        .verifyOtpForForgetPassword(
                            body: EmailOTPVerifyRequest(
                                email: widget.loginReqWithEmail.email,
                                code: verificationCode))
                    : await context.read<AuthProvider>().verifyOtpForSignUp(
                        body: EmailOTPVerifyRequest(
                            email: widget.loginReqWithEmail.email,
                            code: verificationCode));
                if (result != null) {
                  if (widget.isReset) {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CreateNewPasswordPage()),
                    );
                  } else {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: LoginPage()),
                    );
                    context.read<SignUpProvider>().restartSignUpProvider();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: const Size(500, 50),
                backgroundColor: AppColor.orangeColor,
              ),
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
