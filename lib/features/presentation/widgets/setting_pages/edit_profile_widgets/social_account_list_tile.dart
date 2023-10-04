import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/adding_social_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialAccountListTile extends StatelessWidget {
  final socialContactsOptions;
  final socialContact;
  const SocialAccountListTile(
      {super.key,
      required this.socialContactsOptions,
      required this.socialContact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ShowUpAddSocialView(
            socialContactsListLeft: socialContactsOptions,
            body: AddSocialContactRequest(
                userName: socialContact.username!,
                contactType: socialContact.contactType!,
                url: socialContact.profileUrl!),
          ),
        );
      },
      tileColor: Color(0xffE8E8E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: EdgeInsets.only(right: 10, left: 20),
      leading: Icon(socialContact.contactType! == 'FACEBOOK'
          ? Icons.facebook
          : socialContact.contactType! == 'TELEGRAM'
              ? Icons.telegram
              : Icons.chat_bubble_rounded),
      title: Text(
        socialContact.username!,
        style: TextStyle(
          color: Color(0xff000000),
          fontFamily: DefaultTextStyle.of(context).style.fontFamily,
          fontSize: 14,
        ),
      ),
      trailing: TextButton(
        onPressed: () async {
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
                      padding: EdgeInsets.all(20.0),
                      height: 150,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: AppColor.orangeColor,
                            ),
                            SizedBox(height: 16.0),
                            Text('Removing...'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
          final result = await context
              .read<UserProvider>()
              .removeSocialContact(id: socialContact.id!.toString());
          if (result != null) {
            Navigator.pop(context);
            // setState(() {
            socialContactsOptions.add(socialContact.contactType!);
            // });
          }
        },
        child: Text(
          "remove",
          style: TextStyle(
            color: AppColor.blueColor,
            fontFamily: DefaultTextStyle.of(context).style.fontFamily,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
