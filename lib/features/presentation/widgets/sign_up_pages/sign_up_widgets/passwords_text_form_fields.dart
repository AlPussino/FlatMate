import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/sign_up_providers/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordTextFormFields extends StatelessWidget {
  final isPassword;
  const PasswordTextFormFields({super.key, required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.orangeColor,
      focusNode: isPassword
          ? context.watch<SignUpProvider>().passwordFocusNode
          : context.watch<SignUpProvider>().confirmPasswordFocusNode,
      obscureText: isPassword
          ? context.watch<SignUpProvider>().isPasswordObscure
          : context.watch<SignUpProvider>().isConfirmPasswordObscure,
      style: TextStyle(color: AppColor.textColor, fontSize: 14),
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: isPassword ? 'password' : 'confirm password',
        helperText: isPassword
            ? AppString.passwordHelperText
            : AppString.confirmPasswordHelperText,
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColor.greyColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColor.orangeColor,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  context.read<SignUpProvider>().obscurePassword(
                      context.read<SignUpProvider>().isPasswordObscure
                          ? false
                          : true);
                },
                icon: Icon(context.watch<SignUpProvider>().isPasswordObscure
                    ? Icons.visibility
                    : Icons.visibility_off))
            : IconButton(
                onPressed: () {
                  context.read<SignUpProvider>().obscureConfirmPassword(
                      context.read<SignUpProvider>().isConfirmPasswordObscure
                          ? false
                          : true);
                },
                icon: Icon(
                    context.watch<SignUpProvider>().isConfirmPasswordObscure
                        ? Icons.visibility
                        : Icons.visibility_off)),
      ),
      validator: (value) {
        if (isPassword) {
          if (value!.isEmpty) {
            return 'Please enter password';
          } else if (value.length < 8) {
            return 'Password must have at least 8';
          }
          return null;
        } else {
          if (value!.isEmpty) {
            return 'Please enter password';
          } else if (value != context.read<SignUpProvider>().password) {
            return 'Please confirm the same password';
          }
          return null;
        }
      },
      onChanged: (value) {
        isPassword
            ? context.read<SignUpProvider>().savePassword(value)
            : context.read<SignUpProvider>().saveConfirmPassword(value);
      },
    );
  }
}
