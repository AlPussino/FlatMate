import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/signup_request_with_email.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/auth_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/sign_up_providers/sign_up_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/login_page_1.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/sign_up_pages/email_otp_verification_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/sign_up_pages/sign_up_widgets/normal_text_form_fields.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/sign_up_pages/sign_up_widgets/passwords_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: context.read<SignUpProvider>().formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: AppColor.orangeColor,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Fill your information below or",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "register with your google account",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                children: [
                  NormalTextFormFields(
                      isFullName: true, isEmail: false, isPhoneNumber: false),
                  const SizedBox(height: 20),
                  NormalTextFormFields(
                      isFullName: false, isEmail: true, isPhoneNumber: false),
                  const SizedBox(height: 20),
                  NormalTextFormFields(
                      isFullName: false, isEmail: false, isPhoneNumber: true),
                  const SizedBox(height: 20),
                  PasswordTextFormFields(isPassword: true),
                  const SizedBox(height: 20),
                  PasswordTextFormFields(isPassword: false),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (context
                          .read<SignUpProvider>()
                          .formKey
                          .currentState!
                          .validate()) {
                        if (context
                                .read<SignUpProvider>()
                                .isSignUpButtonDisable !=
                            true) {
                          if (context.read<SignUpProvider>().isFormFilled) {
                            context.read<SignUpProvider>().signUp(true);
                            context
                                .read<SignUpProvider>()
                                .disableSignUpButton(true);
                            context.read<SignUpProvider>().unFocusNodes();

                            ///
                            await Future.delayed(Duration(seconds: 1));

                            final result = await context
                                .read<AuthProvider>()
                                .signUpWithEmail(
                                  body: SignUpRequestWithEmail(
                                    username:
                                        context.read<SignUpProvider>().fullName,
                                    email: context.read<SignUpProvider>().email,
                                    mobileNumber: context
                                        .read<SignUpProvider>()
                                        .phoneNumber,
                                    password:
                                        context.read<SignUpProvider>().password,
                                  ),
                                );
                            context.read<SignUpProvider>().signUp(false);
                            context
                                .read<SignUpProvider>()
                                .disableSignUpButton(false);
                            log("Result: $result");
                            if (result != null) {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: EmailOTPVerificationPage(
                                      loginReqWithEmail: SignUpRequestWithEmail(
                                        username: context
                                            .read<SignUpProvider>()
                                            .fullName,
                                        email: context
                                            .read<SignUpProvider>()
                                            .email,
                                        mobileNumber: context
                                            .read<SignUpProvider>()
                                            .phoneNumber,
                                        password: context
                                            .read<SignUpProvider>()
                                            .password,
                                      ),
                                      isReset: false,
                                    )),
                              );
                            } else {
                              null;
                            }

                            ///
                          } else {
                            null;
                          }
                        } else {
                          context
                              .read<SignUpProvider>()
                              .disableSignUpButton(false);
                        }
                      } else {
                        null;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(500, 50),
                      backgroundColor:
                          context.watch<SignUpProvider>().isFormFilled
                              ? AppColor.orangeColor
                              : AppColor.greyColor,
                    ),
                    child: context.read<SignUpProvider>().isSigningUp
                        ? CircularProgressIndicator(
                            color: AppColor.whiteColor,
                          )
                        : Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Or Sign in with Google",
                        style: TextStyle(
                          color: AppColor.greyColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 18),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.blackColor),
                          shape: BoxShape.circle,
                          color: AppColor.transparent,
                        ),
                        child: Image.asset('assets/images/google_logo.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: AppColor.greyColor,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: LogInPage()),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: AppColor.orangeColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
