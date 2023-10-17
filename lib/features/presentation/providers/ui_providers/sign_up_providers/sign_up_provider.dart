import 'dart:developer';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;

  String _fullName = '';
  String get fullName => _fullName;

  String _email = '';
  String get email => _email;

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;

  String _password = '';
  String get password => _password;

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;

  bool _isPasswordObscure = true;
  bool get isPasswordObscure => _isPasswordObscure;

  bool _isConfirmPasswordObscure = true;
  bool get isConfirmPasswordObscure => _isConfirmPasswordObscure;

  bool _isFormFilled = false;
  bool get isFormFilled => _isFormFilled;

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  bool _isSignUpButtonDisable = false;
  bool get isSignUpButtonDisable => _isSignUpButtonDisable;

  FocusNode _fullNameFocusNode = FocusNode();
  FocusNode get fullNameFocusNode => _fullNameFocusNode;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode get emailFocusNode => _emailFocusNode;

  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode get passwordFocusNode => _passwordFocusNode;

  FocusNode _confirmPasswordFocusNode = FocusNode();
  FocusNode get confirmPasswordFocusNode => _confirmPasswordFocusNode;

  void saveFullName(String fullName) {
    _fullName = fullName;
    _isFormFilled = fullName.isNotEmpty &&
            email.isNotEmpty &&
            phoneNumber.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            password == confirmPassword
        ? true
        : false;
    log("Name : $fullName");
    log("IsFormFilled : $isFormFilled");

    notifyListeners();
  }

  void saveEmail(String email) {
    _email = email;

    _isFormFilled = fullName.isNotEmpty &&
            email.isNotEmpty &&
            phoneNumber.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            password == confirmPassword
        ? true
        : false;
    log("Email : $email");
    log("IsFormFilled : $isFormFilled");

    notifyListeners();
  }

  void savePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    _isFormFilled = fullName.isNotEmpty &&
            email.isNotEmpty &&
            phoneNumber.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            password == confirmPassword
        ? true
        : false;

    log("Phone Number : $phoneNumber");
    log("IsFormFilled : $isFormFilled");

    notifyListeners();
  }

  void savePassword(String password) {
    _password = password;

    _isFormFilled = fullName.isNotEmpty &&
            email.isNotEmpty &&
            phoneNumber.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            password == confirmPassword
        ? true
        : false;
    log("Password : $password");
    log("IsFormFilled : $isFormFilled");

    notifyListeners();
  }

  void saveConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    _isFormFilled = fullName.isNotEmpty &&
            email.isNotEmpty &&
            phoneNumber.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            password == confirmPassword
        ? true
        : false;

    log("Confirm Password : $confirmPassword");
    log("IsFormFilled : $isFormFilled");

    notifyListeners();
  }

  void obscurePassword(bool obscurePassword) {
    _isPasswordObscure = obscurePassword;
    log(isPasswordObscure.toString());
    notifyListeners();
  }

  void obscureConfirmPassword(bool obscureConfirmPassword) {
    _isConfirmPasswordObscure = obscureConfirmPassword;
    log(isConfirmPasswordObscure.toString());
    notifyListeners();
  }

  void signUp(bool signUp) {
    _isSigningUp = signUp;
    notifyListeners();
  }

  void disableSignUpButton(bool disableSignUpButton) {
    _isSignUpButtonDisable = disableSignUpButton;
    notifyListeners();
  }

  void unFocusNodes() {
    _fullNameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _phoneNumberFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
  }

  void restartSignUpProvider() {
    _fullName = '';
    _email = '';
    _phoneNumber = '';
    _password = '';
    _confirmPassword = '';
    _isPasswordObscure = true;
    _isConfirmPasswordObscure = true;
    _isFormFilled = false;
    _isSigningUp = false;
    _isSignUpButtonDisable = false;
  }
}
