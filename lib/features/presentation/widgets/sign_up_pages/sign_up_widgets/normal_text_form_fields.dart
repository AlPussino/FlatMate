import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/sign_up_providers/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NormalTextFormFields extends StatelessWidget {
  final isFullName;
  final isPhoneNumber;
  final isEmail;

  const NormalTextFormFields({
    super.key,
    required this.isFullName,
    required this.isEmail,
    required this.isPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.orangeColor,
      focusNode: isFullName
          ? context.watch<SignUpProvider>().fullNameFocusNode
          : isEmail
              ? context.watch<SignUpProvider>().emailFocusNode
              : context.watch<SignUpProvider>().phoneNumberFocusNode,
      style: TextStyle(color: AppColor.textColor, fontSize: 14),
      keyboardType: isFullName
          ? TextInputType.name
          : isEmail
              ? TextInputType.emailAddress
              : TextInputType.number,
      decoration: InputDecoration(
        hintText: isFullName
            ? 'full name'
            : isEmail
                ? 'email'
                : 'phone number',
        helperText: isFullName
            ? AppString.fullNameHelperText
            : isEmail
                ? AppString.emailHelperText
                : AppString.phoneNumberHelperText,
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
      ),
      validator: (value) {
        if (isEmail) {
          if (value!.isEmpty) {
            return 'Please enter Email';
          }
          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
              .hasMatch(value)) {
            return 'Please enter a valid email address.';
          }

          return null;
        } else if (isFullName) {
          if (value!.isEmpty) {
            return 'Please enter username';
          }

          return null;
        } else {
          if (value!.isEmpty) {
            return 'Please enter phone number';
          }

          RegExp regex = RegExp('^09');

          if (!regex.hasMatch(value)) {
            return 'Phone number should start with 09.';
          }

          return null;
        }
      },
      onChanged: (value) {
        isFullName
            ? context.read<SignUpProvider>().saveFullName(value)
            : isEmail
                ? context.read<SignUpProvider>().saveEmail(value)
                : context.read<SignUpProvider>().savePhoneNumber(value);
      },
    );
  }
}
