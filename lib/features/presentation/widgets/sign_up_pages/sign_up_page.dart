import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/auth_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/login_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/sign_up_pages/email_otp_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../data/models/requests/signup_request_with_email.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  late bool isLoggingIn = false;
  bool isButtonDisabled = false;

  bool nameError = false;
  bool emailError = false;
  bool phoneNumberError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;

  bool _showError = false;
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30, right: 24, left: 24),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                      color: AppColor.orangeColor,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Fill your information below or",
                    style: TextStyle(
                      //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "register with your google account",
                    style: TextStyle(
                      //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(
                        color: AppColor.textColor,
                        //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                      hintText: 'full name',
                      helperText:
                          'username should be between 3 and 20 characters',
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
                        nameError = !isNameValid(value);
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
                        return 'Please enter username';
                      }
                      // RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
                      // if (!usernameRegex.hasMatch(value)) {
                      //   return 'Invalid username';
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      _nameController.text = value!;
                      _nameFocusNode.unfocus();
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(
                        color: AppColor.textColor,
                        //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      hintText: 'email',
                      helperText: 'Enter a valid email',
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
                      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address.';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _emailController.text = value!;
                      _emailFocusNode.unfocus();
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(
                        color: AppColor.textColor,
                        //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    focusNode: _phoneNumberFocusNode,
                    decoration: InputDecoration(
                      hintText: 'phone number',
                      helperText: 'Enter a valid phone number',
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
                        phoneNumberError = !isPhoneNumberValid(value);
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
                        return 'Please enter phone number';
                      }

                      // Define the regex pattern
                      RegExp regex = RegExp('^09');

                      if (!regex.hasMatch(value)) {
                        return 'Phone number should start with 09.';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _phoneNumberController.text = value!;
                      _phoneNumberFocusNode.unfocus();
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(
                        color: AppColor.textColor,
                        //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    obscureText: _passwordObscureText,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'password',
                      helperText: "Password must be at least 8",
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
                      } else if (value.length < 8) {
                        return 'Password must have at least 8';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _passwordController.text = value!;
                      _passwordFocusNode.unfocus();
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(
                        color: AppColor.textColor,
                        //fontFamily:DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),

                    textInputAction: TextInputAction.done,
                    controller: _confirmPasswordController,
                    obscureText: _confirmPasswordObscureText,
                    focusNode: _confirmPasswordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'confirm password',
                      helperText: "Confirm the same password",
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
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _confirmPasswordObscureText =
                                !_confirmPasswordObscureText;
                          });
                        },
                        icon: Icon(
                          _confirmPasswordObscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.greyColor,
                          size: 20,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        confirmPasswordError = !isConfirmPasswordValid(value);
                        isLoggingIn = false;
                      });
                      if (_showError) {
                        setState(() {
                          _showError = false;
                        });
                      }
                    },
                    // onSubmitted: (s) {
                    //   _focusNode.unfocus();
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 8) {
                        return 'Please confirm the same password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _confirmPasswordController.text = value!;
                      _confirmPasswordFocusNode.unfocus();
                    },
                  ),
                ],
              ),
              SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      log(isButtonDisabled.toString());
                      isButtonDisabled ? null : handleButtonClick();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: Size(500, 50),
                      backgroundColor: _nameController.text.isNotEmpty &&
                              _phoneNumberController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty &&
                              _passwordController.text ==
                                  _confirmPasswordController.text &&
                              _passwordController.text.length >= 8
                          ? AppColor.orangeColor
                          : AppColor.greyColor,
                    ),
                    child: isLoggingIn
                        ? CircularProgressIndicator(color: AppColor.whiteColor)
                        : Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              // fontFamily:
                              //     DefaultTextStyle.of(context).style.fontFamily,
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
                          // fontFamily:
                          //     DefaultTextStyle.of(context).style.fontFamily,
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
                          // fontFamily:
                          //     DefaultTextStyle.of(context).style.fontFamily,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: LoginPage()),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: AppColor.orangeColor,
                            // fontFamily:
                            //     DefaultTextStyle.of(context).style.fontFamily,
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

  bool isNameValid(String name) {
    return name.isNotEmpty;
  }

  bool isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  bool isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool isConfirmPasswordValid(String confirmPassword) {
    return confirmPassword.isNotEmpty;
  }

  void handleButtonClick() async {
    if (!isButtonDisabled) {
      setState(() {
        isButtonDisabled = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          isLoggingIn = true;
        });
        if (_nameController.text.isNotEmpty &&
            _emailController.text.isNotEmpty &&
            _phoneNumberController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _confirmPasswordController.text.isNotEmpty &&
            _passwordController.text == _confirmPasswordController.text &&
            _passwordController.text.length >= 8) {
          _passwordFocusNode.unfocus();
          final result = await context.read<AuthProvider>().signUpWithEmail(
              body: SignUpRequestWithEmail(
                  username: _nameController.text,
                  email: _emailController.text,
                  mobileNumber: _phoneNumberController.text,
                  password: _passwordController.text));

          if (result != null) {
            setState(() {
              isLoggingIn = false;
              isButtonDisabled = false;
            });

            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: EmailOTPVerificationPage(
                    loginReqWithEmail: SignUpRequestWithEmail(
                        username: _nameController.text,
                        email: _emailController.text,
                        mobileNumber: _phoneNumberController.text,
                        password: _passwordController.text),
                    isReset: false,
                  )),
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
