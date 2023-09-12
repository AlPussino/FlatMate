import 'package:finding_apartments_yangon/features/presentation/providers/auth_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../data/models/requests/email_otp_verify_request.dart';
import '../../../data/models/requests/signup_request_with_email.dart';

class EmailOTPVerificationPage extends StatefulWidget {
  final SignUpRequestWithEmail loginReqWithEmail;
  const EmailOTPVerificationPage({super.key, required this.loginReqWithEmail});

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
                    fontFamily: 'Dosis',
                    color: Color(0xffF2AE00),
                    fontSize: 24,
                  ),
                ),
                Text(
                  "A verification code has been sent to ${widget.loginReqWithEmail.email}",
                  style: TextStyle(
                    fontFamily: 'Dosis',
                    color: Color(0xff534F4F),
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
                underlineColor: const Color(0xffF2AE00),
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
                final result = await context
                    .read<AuthProvider>()
                    .emailOtpVerification(
                        body: EmailOTPVerifyRequest(
                            email: widget.loginReqWithEmail.email,
                            code: verificationCode));
                if (result != null) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: LoginPage()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: const Size(500, 50),
                backgroundColor: const Color(0xffF2AE00),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Dosis',
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
