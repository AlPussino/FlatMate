import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/text_form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullNameListTile extends StatelessWidget {
  final myUser;
  FullNameListTile({super.key, required this.myUser});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> fullNameFormKey = GlobalKey<FormState>();
    String tempFullNameToCheckChanges = myUser.username;

    _nameController.text = myUser.username;
    return ListTile(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            surfaceTintColor: AppColor.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              padding: EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 82,
                width: 400,
                child: Form(
                  key: fullNameFormKey,
                  child: TextFormField(
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: AppColor.textColor,
                        fontSize: 14),
                    controller: _nameController,
                    cursorColor: AppColor.orangeColor,
                    decoration: TextFormFieldDecoration.textFormFieldDecoration(
                        'Full Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Full name';
                      }
                      if (value == tempFullNameToCheckChanges) {
                        return 'Change Full Name to update';
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
                    if (fullNameFormKey.currentState!.validate()) {
                      final result = await context
                          .read<UserProvider>()
                          .changeUserName(userName: _nameController.text);
                      if (result != null) {
                        Navigator.pop(context);
                      } else {}
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: AppColor.orangeColor, fontSize: 14),
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
        myUser.username ?? '',
        style: TextStyle(
          color: Color(0xff000000),
          fontFamily: DefaultTextStyle.of(context).style.fontFamily,
          fontSize: 14,
        ),
      ),
    );
  }
}
