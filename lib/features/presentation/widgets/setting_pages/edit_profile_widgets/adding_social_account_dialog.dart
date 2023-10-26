import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowUpAddSocialView extends StatefulWidget {
  final AddSocialContactRequest? body;
  final List<String> socialContactsListLeft;
  ShowUpAddSocialView(
      {super.key, this.body, required this.socialContactsListLeft});

  @override
  State<ShowUpAddSocialView> createState() => _ShowUpAddSocialViewState();
}

class _ShowUpAddSocialViewState extends State<ShowUpAddSocialView> {
  GlobalKey<FormState> socialContactsFormKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _accountLinkController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _accountNameFocusNode = FocusNode();
  final _accountLinkFocusNode = FocusNode();
  String? tempAccountNameToCheckChange;
  String? tempAccountLinkToCheckChange;
  @override
  void dispose() {
    _accountLinkController.dispose();
    _accountNameController.dispose();
    _phoneNumberController.dispose();
    _accountNameFocusNode.dispose();
    _accountLinkFocusNode.dispose();
    super.dispose();
  }

  String selectedSocialContact = '';
  // List<String> socialContactsListAll = ["FACEBOOK", "INSTAGRAM", "TELEGRAM"];

  List<String> socialContactsListForEdit = [];

  @override
  void initState() {
    if (widget.body != null) {
      _accountNameController.text = widget.body!.userName;
      _accountLinkController.text = widget.body!.url;
      selectedSocialContact = widget.body!.contactType;
      socialContactsListForEdit = [widget.body!.contactType];
      tempAccountNameToCheckChange = widget.body!.userName;
      tempAccountLinkToCheckChange = widget.body!.url;
    } else {
      selectedSocialContact = widget.socialContactsListLeft[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      surfaceTintColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        padding: EdgeInsets.only(top: 40),
        child: SizedBox(
          height: 270,
          width: 400,
          child: Form(
            key: socialContactsFormKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.greyColor, // Border color
                    ),
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: AbsorbPointer(
                        absorbing: widget.body != null ? true : false,
                        child: DropdownButton(
                          dropdownColor: AppColor.whiteColor,
                          isExpanded: true,
                          autofocus: true,
                          underline: SizedBox(),
                          alignment: Alignment.centerLeft,
                          borderRadius: BorderRadius.circular(10),
                          style: TextStyle(
                            color: AppColor.greyColor,
                            fontFamily:
                                DefaultTextStyle.of(context).style.fontFamily,
                            fontSize: 14,
                          ),
                          value: selectedSocialContact,
                          onChanged: (newValue) {
                            setState(() {
                              selectedSocialContact = newValue!;
                            });
                          },
                          items: widget.body == null
                              ? widget.socialContactsListLeft
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                              : socialContactsListForEdit
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                  return DropdownMenuItem<String>(
                                    enabled: false,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  focusNode: _accountNameFocusNode,
                  cursorColor: AppColor.orangeColor,
                  style: TextStyle(color: AppColor.textColor, fontSize: 14),
                  controller: _accountNameController,
                  decoration: _buildDeco('Account name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Account name';
                    }
                    // if (value == tempAccountNameToCheckChange) {
                    //   return 'Change Account name to update';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  focusNode: _accountLinkFocusNode,
                  cursorColor: AppColor.orangeColor,
                  style: TextStyle(color: AppColor.textColor, fontSize: 14),
                  controller: _accountLinkController,
                  decoration: _buildDeco('profile link'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Profile link';
                    }
                    // if (value == tempAccountLinkToCheckChange) {
                    //   return 'Change Profile link to update';
                    // }
                    final RegExp facebookRegex = RegExp(
                        '(?:http:\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(\d.*))?([\w\-]*)?');

                    final RegExp instagramRegex = RegExp(
                        r'^(http(s)?://)?(www\.)?instagram.com/([a-zA-Z0-9._]*)/?([a-zA-Z0-9._]*)');
                    final RegExp telegramRegex = RegExp(
                        r'^(http(s)?:\/\/)?(t\.me|web\.telegram\.org)\/[\w][\w\d_]+$');
                    switch (selectedSocialContact) {
                      case 'FACEBOOK':
                        if (!facebookRegex.hasMatch(value)) {
                          return "Enter valid  facebook profile link";
                        }
                        break;
                      case 'INSTAGRAM':
                        if (!instagramRegex.hasMatch(value)) {
                          return "Enter valid instagram profile link";
                        }

                        break;
                      case 'TELEGRAM':
                        if (!telegramRegex.hasMatch(value)) {
                          return "Enter valid telegram profile link";
                        }
                    }
                    return null;
                  },
                ),
              ],
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
            if (socialContactsFormKey.currentState!.validate()) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  useRootNavigator: true,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      surfaceTintColor: AppColor.whiteColor,
                      child: SizedBox(
                        width: 50,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 150,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: AppColor.orangeColor,
                                ),
                                SizedBox(height: 16.0),
                                Text('Adding...'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });

              if (selectedSocialContact == 'TELEGRAM') {
                _accountLinkController.text.contains('http')
                    ? null
                    : _accountLinkController.text =
                        "https://${_accountLinkController.text}";
              }

              final result = await context
                  .read<UserProvider>()
                  .addSocialContact(AddSocialContactRequest(
                      userName: _accountNameController.text,
                      url: _accountLinkController.text,
                      contactType: selectedSocialContact));

              log("$result");
              if (result != null) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            }
          },
          child: Text(
            'Save',
            style: TextStyle(color: AppColor.orangeColor, fontSize: 14),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildDeco(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Color(0xffFAFAFA),
      labelText: hint,
      labelStyle: TextStyle(color: AppColor.greyColor),
      contentPadding: EdgeInsets.all(20),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xff757575),
      ),
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
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
    );
  }
}
