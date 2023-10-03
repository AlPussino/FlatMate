import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/change_password_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/log_in_pages/login_page.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Setting",
          style: TextStyle(
            color: Color(0xff000000),
            // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "Account",
              style: TextStyle(
                color: Color(0xff534F4F),
                // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                fontSize: 14,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: EditProfilePage()),
                );
              },
              contentPadding: EdgeInsets.only(right: 0),
              minLeadingWidth: 20,
              title: Row(
                children: [
                  Icon(
                    Icons.mode_edit_outline_outlined,
                    color: Color(0xff534F4F),
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Edit profile",
                    style: TextStyle(
                      color: Color(0xff000000),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color(0xff534F4F),
                size: 15,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ChangePasswordPage()),
                );
              },
              contentPadding: EdgeInsets.only(right: 0),
              minLeadingWidth: 20,
              title: Row(
                children: [
                  Icon(
                    Icons.password,
                    color: Color(0xff534F4F),
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Change password",
                    style: TextStyle(
                      color: Color(0xff000000),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color(0xff534F4F),
                size: 15,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Text(
              "About",
              style: TextStyle(
                color: Color(0xff534F4F),
                // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                fontSize: 14,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(right: 0),
              minLeadingWidth: 20,
              title: Row(
                children: [
                  Icon(
                    Icons.question_mark_outlined,
                    color: Color(0xff534F4F),
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      color: Color(0xff000000),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color(0xff534F4F),
                size: 15,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(right: 0),
              minLeadingWidth: 20,
              title: Row(
                children: [
                  Icon(
                    Icons.question_mark_outlined,
                    color: Color(0xff534F4F),
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Privacy and Policy",
                    style: TextStyle(
                      color: Color(0xff000000),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color(0xff534F4F),
                size: 15,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(right: 0),
              minLeadingWidth: 20,
              title: Row(
                children: [
                  Icon(
                    Icons.question_mark_outlined,
                    color: Color(0xff534F4F),
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "About app",
                    style: TextStyle(
                      color: Color(0xff000000),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color(0xff534F4F),
                size: 15,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Text(
              "Contact",
              style: TextStyle(
                color: Color(0xff534F4F),
                // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                fontSize: 14,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 20,
              title: Row(
                children: [
                  Icon(
                    Icons.web,
                    color: Color(0xff534F4F),
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Developers contact",
                    style: TextStyle(
                      color: Color(0xff000000),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color(0xff534F4F),
                size: 15,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Text(
              "Log out",
              style: TextStyle(
                color: Color(0xff534F4F),
                // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: Size(500, 50),
                backgroundColor: Color(0xffF2AE00),
              ),
              child: Text(
                "Log out",
                style: TextStyle(
                  color: Colors.white,
                  // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
