import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/token_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/adding_social_account_dialog.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/edit_profile_card.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/full_name_list_tile.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/phone_number_list_tile.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/social_account_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../log_in_pages/login_page.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTokenExpired = context.read<TokenProvider>().isTokenExpired();
    if (isTokenExpired) {
      final user = context.read<UserProvider>().getUserInfo();
      user.then(
        (value) {
          if (value == null) {
            Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRight, child: LoginPage()),
            );
          }
        },
      );
    }

    List<String> socialContactsOptions = [
      'FACEBOOK',
      'INSTAGRAM',
      'TELEGRAM',
    ];

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.whiteColor,
          foregroundColor: AppColor.blackColor,
          title: Text(
            "Edit profile",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 20,
            ),
          ),
        ),
        body: FutureBuilder(
          future: context.read<UserProvider>().getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.orangeColor,
                ),
              );
            }
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                    fontSize: 20,
                  ),
                ),
              );
            }

            final myUser = context.watch<UserProvider>().user;
            myUser!.socialContacts!.map((e) {
              log(e.id.toString());
              if (socialContactsOptions.contains(e.contactType)) {
                socialContactsOptions.remove(e.contactType);
              }
            }).toList();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditProfileCard(myUser: myUser),
                    SizedBox(height: 40),
                    Text(
                      "Full name",
                      style: TextStyle(
                        color: AppColor.greyColor,
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),

                    /// Full Name ListTile
                    FullNameListTile(myUser: myUser),

                    ///
                    SizedBox(height: 15),
                    Text(
                      "Phone number",
                      style: TextStyle(
                        color: AppColor.greyColor,
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),

                    /// Phone Number ListTile
                    PhoneNumberListTile(myUser: myUser),

                    ///
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Social accounts",
                          style: TextStyle(
                            color: AppColor.greyColor,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            socialContactsOptions.isEmpty
                                ? null
                                : showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => ShowUpAddSocialView(
                                        socialContactsListLeft:
                                            socialContactsOptions),
                                  );
                          },
                          child: Offstage(
                            offstage:
                                socialContactsOptions.isEmpty ? true : false,
                            child: Text(
                              'add',
                              style: TextStyle(
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ...myUser.socialContacts!.map((socialContact) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: SocialAccountListTile(
                            socialContactsOptions: socialContactsOptions,
                            socialContact: socialContact),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
