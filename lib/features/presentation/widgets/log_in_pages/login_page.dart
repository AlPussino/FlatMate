import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/login_request_with_email.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/bottom_navigation_bar_page.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/auth_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/token_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/forget_password_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/sign_up_pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late bool isLoggingIn = false;
  bool isButtonDisabled = false;

  bool emailError = false;
  bool passwordError = false;
  bool _showError = false;
  bool _passwordObscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 24, left: 24),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
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
                    "Hi welcome back, you've been missed mother fucker",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(color: AppColor.textColor, fontSize: 14),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      hintText: 'email',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        emailError = !isEmailValid(value);
                        isLoggingIn = false;
                      });

                      if (_showError) {
                        setState(() {
                          _showError = false;
                        });
                      }
                    },
                    enabled: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Email';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _emailController.text = value!;
                      _emailFocusNode.unfocus();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(color: AppColor.textColor, fontSize: 14),
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    obscureText: _passwordObscureText,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'password',
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.greyColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordObscureText = !_passwordObscureText;
                          });
                        },
                        icon: Icon(
                          _passwordObscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.greyColor,
                          size: 20,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        passwordError = !isPasswordValid(value);
                        isLoggingIn = false;
                      });
                      if (_showError) {
                        setState(() {
                          _showError = false;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _passwordController.text = value!;
                      _passwordFocusNode.unfocus();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      isButtonDisabled ? null : handleButtonClick();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(500, 50),
                      backgroundColor: _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty
                          ? AppColor.orangeColor
                          : AppColor.greyColor,
                    ),
                    child: isLoggingIn
                        ? const CircularProgressIndicator(
                            color: AppColor.whiteColor)
                        : Text(
                            'Sign in',
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
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const BottomNavigationBarPage()),
                          );
                        },
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

  bool isEmailValid(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  bool isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  void handleButtonClick() async {
    String deviceId = await context.read<TokenProvider>().getDeviceId();
    log("DeviceId : $deviceId");
    if (!isButtonDisabled) {
      setState(() {
        isButtonDisabled = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          isLoggingIn = true;
        });
        final nav = Navigator.of(context);
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          _passwordFocusNode.unfocus();
          final result = await context
              .read<AuthProvider>()
              .logInWithEmail(LogInRequestWithEmail(
                email: _emailController.text,
                password: _passwordController.text,
                deviceId: deviceId,
              ));

          if (result != null) {
            setState(() {
              isLoggingIn = false;
              isButtonDisabled = false;
            });

            nav.pushAndRemoveUntil(
              MaterialPageRoute(
                  settings: const RouteSettings(name: 'home'),
                  builder: (BuildContext context) =>
                      const BottomNavigationBarPage()),
              (Route<dynamic> route) => false,
            );
          } else {
            setState(() {
              isLoggingIn = false;
              isButtonDisabled = false;
            });
          }
        } else {
          null;
        }
        setState(() {
          isLoggingIn = false;
          isButtonDisabled = false;
        });
      } else {
        setState(() {
          isButtonDisabled = false;
          _showError = true;
        });
      }
    }
  }
}
