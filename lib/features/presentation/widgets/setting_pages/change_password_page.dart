import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _currentPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool currentPasswordError = false;
  bool newPasswordError = false;
  bool confirmPasswordError = false;

  bool isButtonDisabled = false;
  bool _showError = false;
  bool isLoggingIn = false;

  bool _currentPasswordObscureText = true;
  bool _newPasswordObscureText = true;
  bool _confirmPasswordObscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.whiteColor,
        foregroundColor: AppColor.blackColor,
        title: Text(
          "Change password",
          style: TextStyle(
            color: Color(0xff000000),
            // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 24, left: 24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current password",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(color: AppColor.textColor, fontSize: 14),
                    textInputAction: TextInputAction.done,
                    controller: _currentPasswordController,
                    obscureText: _currentPasswordObscureText,
                    focusNode: _currentPasswordFocusNode,
                    decoration: InputDecoration(
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
                            _currentPasswordObscureText =
                                !_currentPasswordObscureText;
                          });
                        },
                        icon: Icon(
                          _currentPasswordObscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.greyColor,
                          size: 20,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        currentPasswordError = !isCurrentPasswordValid(value);
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
                      _currentPasswordController.text = value!;
                      _currentPasswordFocusNode.unfocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "New password",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(color: AppColor.textColor, fontSize: 14),
                    textInputAction: TextInputAction.done,
                    controller: _newPasswordController,
                    obscureText: _newPasswordObscureText,
                    focusNode: _newPasswordFocusNode,
                    decoration: InputDecoration(
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
                            _newPasswordObscureText = !_newPasswordObscureText;
                          });
                        },
                        icon: Icon(
                          _newPasswordObscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.greyColor,
                          size: 20,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        newPasswordError = !isNewPasswordValid(value);
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
                      if (value.length < 8) {
                        return 'Password must be at least 8';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newPasswordController.text = value!;
                      _newPasswordFocusNode.unfocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Confirm password",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(color: AppColor.textColor, fontSize: 14),
                    textInputAction: TextInputAction.done,

                    controller: _confirmPasswordController,
                    obscureText: _confirmPasswordObscureText,
                    focusNode: _confirmPasswordFocusNode,
                    decoration: InputDecoration(
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
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords must be same';
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
                      isButtonDisabled ? null : handleButtonClick();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(500, 50),
                      backgroundColor:
                          _currentPasswordController.text.isNotEmpty &&
                                  _newPasswordController.text.isNotEmpty &&
                                  _confirmPasswordController.text.isNotEmpty &&
                                  _newPasswordController.text ==
                                      _confirmPasswordController.text &&
                                  _newPasswordController.text.length >= 8
                              ? AppColor.orangeColor
                              : AppColor.greyColor,
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
            ],
          ),
        ),
      ),
    );
  }

  bool isCurrentPasswordValid(String currentPassword) {
    return currentPassword.isNotEmpty;
  }

  bool isNewPasswordValid(String newPassword) {
    return newPassword.isNotEmpty;
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
        if (_currentPasswordController.text.isNotEmpty &&
            _newPasswordController.text.isNotEmpty &&
            _confirmPasswordController.text.isNotEmpty &&
            _newPasswordController.text == _confirmPasswordController.text &&
            _newPasswordController.text.length >= 8) {
          //
          final result = await context.read<UserProvider>().changePassword(
              currentPassword: _currentPasswordController.text,
              newPassword: _newPasswordController.text);

          if (result != null) {
            setState(() {
              isLoggingIn = false;
              isButtonDisabled = false;
            });

            Navigator.pop(context);
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
