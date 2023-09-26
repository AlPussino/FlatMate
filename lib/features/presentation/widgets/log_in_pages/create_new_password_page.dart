import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import 'login_page.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  late bool isLoggingIn = false;
  bool isButtonDisabled = false;

  bool passwordError = false;
  bool confirmPasswordError = false;

  bool _showError = false;
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
            children: [
              Column(
                children: [
                  Text(
                    "Create new Password",
                    style: TextStyle(
                      fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      color: Color(0xffF2AE00),
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Let's create new password mother fucker",
                    style: TextStyle(
                      fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      color: Color(0xff534F4F),
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
                    cursorColor: Color(0xffF2AE00),
                    style: TextStyle(
                        color: Color(0xff2E2E2E),
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    obscureText: _passwordObscureText,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'new password',
                      helperText: "Password must be at least 8",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
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
                          color: const Color(0xff534F4F),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(
                        color: Color(0xff2E2E2E),
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),

                    textInputAction: TextInputAction.done,
                    controller: _confirmPasswordController,
                    obscureText: _confirmPasswordObscureText,
                    focusNode: _confirmPasswordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'confirm password',
                      helperText: "Confirm the same password",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff534F4F),
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
                          color: const Color(0xff534F4F),
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
              const SizedBox(height: 32),
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
                      minimumSize: const Size(500, 50),
                      backgroundColor: _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty &&
                              _passwordController.text ==
                                  _confirmPasswordController.text &&
                              _passwordController.text.length >= 8
                          ? const Color(0xffF2AE00)
                          : Colors.grey,
                    ),
                    child: isLoggingIn
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily:
                                  DefaultTextStyle.of(context).style.fontFamily,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
        if (_passwordController.text.isNotEmpty &&
            _confirmPasswordController.text.isNotEmpty &&
            _passwordController.text == _confirmPasswordController.text &&
            _passwordController.text.length >= 8) {
          _passwordFocusNode.unfocus();
          log('yay');
          final result = await context
              .read<AuthProvider>()
              .createNewPassword(_passwordController.text);

          if (result != null) {
            setState(() {
              isLoggingIn = false;
              isButtonDisabled = false;
            });

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: LoginPage()),
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
