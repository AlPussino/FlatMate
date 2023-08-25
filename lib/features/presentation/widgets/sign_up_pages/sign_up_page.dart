import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  late bool isLoggingIn = false;
  bool nameError = false;
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
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
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
              const Column(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: Color(0xffF2AE00),
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Fill your information below or",
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: Color(0xff534F4F),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "register with your google account",
                    style: TextStyle(
                      fontFamily: 'Dosis',
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
                  const Text(
                    "Full name",
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: Color(0xff534F4F),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(
                        color: Color(0xff2E2E2E),
                        fontFamily: 'Dosis',
                        fontSize: 14),
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
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
                      return null;
                    },
                    onSaved: (value) {
                      _nameController.text = value!;
                      _nameFocusNode.unfocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Phone number",
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: Color(0xff534F4F),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(
                        color: Color(0xff2E2E2E),
                        fontFamily: 'Dosis',
                        fontSize: 14),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _phoneFocusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
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
                        return 'Please enter Email or Phone Number';
                      }

                      // Define the regex pattern
                      // RegExp regex = RegExp('^09');

                      // if (!regex.hasMatch(value)) {
                      //   return 'Phone number should start with 09.';
                      // }

                      return null;
                    },
                    onSaved: (value) {
                      _phoneNumberController.text = value!;
                      _phoneFocusNode.unfocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: Color(0xff534F4F),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(
                        color: Color(0xff2E2E2E),
                        fontFamily: 'Dosis',
                        fontSize: 14),
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    obscureText: _passwordObscureText,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
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
                    // onSubmitted: (s) {
                    //   _focusNode.unfocus();
                    // },
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
                  const SizedBox(height: 16),
                  const Text(
                    "Confirm password",
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: Color(0xff534F4F),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(
                        color: Color(0xff2E2E2E),
                        fontFamily: 'Dosis',
                        fontSize: 14),
                    textInputAction: TextInputAction.done,
                    controller: _confirmPasswordController,
                    obscureText: _confirmPasswordObscureText,
                    focusNode: _confirmPasswordFocusNode,
                    decoration: InputDecoration(
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(500, 50),
                      backgroundColor: const Color(0xffF2AE00),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Dosis',
                        fontSize: 16,
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
                      const Text(
                        "Or Sign in with Google",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Image.asset('assets/images/google_logo.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const LoginPage()),
                          );
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(0xffF2AE00),
                            fontFamily: 'Dosis',
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

  bool isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  bool isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool isConfirmPasswordValid(String confirmPassword) {
    return confirmPassword.isNotEmpty;
  }
}
