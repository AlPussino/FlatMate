import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../data/models/requests/signup_request_with_email.dart';
import '../../providers/auth_provider.dart';
import '../sign_up_pages/email_otp_verification_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  late bool isLoggingIn = false;
  bool isButtonDisabled = false;

  bool emailError = false;
  bool _showError = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),
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
                    "Forget password?",
                    style: TextStyle(
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      color: Color(0xffF2AE00),
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "I already know your brain sucks!",
                    style: TextStyle(
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
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
                        // fontFamily:
                        //     DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      hintText: 'email',
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
                      backgroundColor: _emailController.text.isNotEmpty
                          ? const Color(0xffF2AE00)
                          : Colors.grey,
                    ),
                    child: isLoggingIn
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              // fontFamily:
                              //     DefaultTextStyle.of(context).style.fontFamily,
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

  bool isEmailValid(String phoneNumber) {
    return phoneNumber.isNotEmpty;
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
        if (_emailController.text.isNotEmpty) {
          final result = await context
              .read<AuthProvider>()
              .forgetPassword(_emailController.text);
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
                        username: '',
                        email: _emailController.text,
                        mobileNumber: '',
                        password: ''),
                    isReset: true,
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
