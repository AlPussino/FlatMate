import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/text_form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneNumberListTile extends StatelessWidget {
  final myUser;
  PhoneNumberListTile({super.key, required this.myUser});

  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
    _phoneNumberController.text = myUser.mobileNumber;
    String TempPhoneNumberToCheckChanges = myUser.mobileNumber;

    return ListTile(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            surfaceTintColor: AppColor.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: Container(
              padding: EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 82,
                width: 400,
                child: Form(
                  key: phoneNumberFormKey,
                  child: TextFormField(
                    cursorColor: AppColor.orangeColor,
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                    controller: _phoneNumberController,
                    decoration: TextFormFieldDecoration.textFormFieldDecoration(
                        "Phone Number"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone number';
                      }

                      RegExp regex = RegExp('^09');

                      if (!regex.hasMatch(value)) {
                        return 'Phone number should start with 09.';
                      }
                      if (value == TempPhoneNumberToCheckChanges) {
                        return 'Change Phone number to update';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppColor.textColor, fontSize: 14),
                  )),
              TextButton(
                  onPressed: () async {
                    if (phoneNumberFormKey.currentState!.validate()) {
                      final result = await context
                          .read<UserProvider>()
                          .changeMobileNumber(
                              mobileNumber: _phoneNumberController.text);
                      if (result != null) {
                        _phoneNumberController.clear();
                        Navigator.pop(context);
                      } else {}
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: AppColor.orangeColor,
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14),
                  ))
            ],
          ),
        );
      },
      tileColor: Color(0xffE8E8E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.only(right: 10, left: 20),
      title: Text(
        myUser.mobileNumber ?? '',
        style: TextStyle(
          color: Color(0xff000000),
          fontFamily: DefaultTextStyle.of(context).style.fontFamily,
          fontSize: 14,
        ),
      ),
    );
  }
}
