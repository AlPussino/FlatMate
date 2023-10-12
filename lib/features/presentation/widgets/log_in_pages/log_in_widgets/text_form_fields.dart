import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/log_in_providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormFields extends StatelessWidget {
  final isEmail;
  const TextFormFields({super.key, required this.isEmail});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.orangeColor,
      focusNode: isEmail
          ? context.watch<LogInProvider>().emailFocusNode
          : context.watch<LogInProvider>().passwordFocusNode,
      obscureText:
          isEmail ? false : context.watch<LogInProvider>().isPasswordObscure,
      style: TextStyle(color: AppColor.textColor, fontSize: 14),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: isEmail ? 'email' : 'password',
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
        suffixIcon: isEmail
            ? null
            : IconButton(
                onPressed: () {
                  context.read<LogInProvider>().obscurePassword(
                      context.read<LogInProvider>().isPasswordObscure
                          ? false
                          : true);
                },
                icon: Icon(context.watch<LogInProvider>().isPasswordObscure
                    ? Icons.visibility
                    : Icons.visibility_off)),
      ),
      onChanged: (value) {
        isEmail
            ? context.read<LogInProvider>().saveEmail(value)
            : context.read<LogInProvider>().savePassword(value);
      },
    );
  }
}
