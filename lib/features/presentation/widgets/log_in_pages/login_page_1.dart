import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/bottom_navigation_bar_page.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/auth_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/token_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/log_in_providers/log_in_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/forget_password_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/log_in_widgets/text_form_fields.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/sign_up_pages/sign_up_page1.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: context.read<LogInProvider>().formKey,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Column(
                children: [
                  Text(
                    "Sign in",
                    style: TextStyle(
                      color: AppColor.orangeColor,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Hi welcome back, you've been missed, mother fucker",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  TextFormFields(
                    isEmail: true,
                  ),
                  const SizedBox(height: 20),
                  TextFormFields(
                    isEmail: false,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (context
                          .read<LogInProvider>()
                          .formKey
                          .currentState!
                          .validate()) {
                        if (context
                                .read<LogInProvider>()
                                .isLogInButtonDisable !=
                            true) {
                          if (context
                              .read<LogInProvider>()
                              .isEmailAndPasswordFilled) {
                            context.read<LogInProvider>().loginIn(true);
                            context
                                .read<LogInProvider>()
                                .disableLoginButton(true);
                            context.read<LogInProvider>().unFocusNodes();

                            ///
                            await Future.delayed(Duration(seconds: 1));
                            String deviceId = await context
                                .read<TokenProvider>()
                                .getDeviceId();
                            log("DeviceId : $deviceId");

                            final navigator = Navigator.of(context);
                            final result = await context
                                .read<AuthProvider>()
                                .logInWithEmail(
                                  LogInRequestWithEmail(
                                    email: context.read<LogInProvider>().email,
                                    password:
                                        context.read<LogInProvider>().password,
                                    deviceId: deviceId,
                                  ),
                                );
                            context.read<LogInProvider>().loginIn(false);
                            context
                                .read<LogInProvider>()
                                .disableLoginButton(false);

                            if (result != null) {
                              navigator.pushAndRemoveUntil(
                                MaterialPageRoute(
                                    settings: const RouteSettings(name: 'home'),
                                    builder: (BuildContext context) =>
                                        const BottomNavigationBarPage()),
                                (Route<dynamic> route) => false,
                              );
                              context
                                  .read<LogInProvider>()
                                  .restartLogInProvider();
                            } else {
                              null;
                            }

                            ///
                          } else {
                            null;
                          }
                        } else {
                          context
                              .read<LogInProvider>()
                              .disableLoginButton(false);
                        }
                      } else {
                        null;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(500, 50),
                      backgroundColor: context
                              .watch<LogInProvider>()
                              .isEmailAndPasswordFilled
                          ? AppColor.orangeColor
                          : AppColor.greyColor,
                    ),
                    child: context.read<LogInProvider>().isLoginIn
                        ? CircularProgressIndicator(
                            color: AppColor.whiteColor,
                          )
                        : Text(
                            'Log in',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 16,
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ForgetPasswordPage()),
                      );
                    },
                    child: Text(
                      "Forget password?",
                      style: TextStyle(
                        color: AppColor.orangeColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
                      const SizedBox(height: 18),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.blackColor),
                            shape: BoxShape.circle,
                            color: AppColor.transparent,
                          ),
                          child: Image.asset('assets/images/google_logo.png'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 160),
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
                                type: PageTransitionType.rightToLeft,
                                child: SignUpPage()),
                          );
                        },
                        child: Text(
                          "Sign up",
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
