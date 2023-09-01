import 'package:finding_apartments_yangon/features/presentation/widgets/setting/change_password_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Color(0xff000000),
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "Account",
              style: TextStyle(
                color: Color(0xff534F4F),
                fontFamily: 'Dosis',
                fontSize: 14,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const EditProfilePage()),
                );
              },
              contentPadding: const EdgeInsets.only(right: 0),
              minLeadingWidth: 20,
              title: const Row(
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
                      fontFamily: 'Dosis',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(
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
                      child: const ChangePasswordPage()),
                );
              },
              contentPadding: const EdgeInsets.only(right: 0),
              minLeadingWidth: 20,
              title: const Row(
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
                      fontFamily: 'Dosis',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Color(0xff534F4F),
                size: 15,
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Text(
              "About",
              style: TextStyle(
                color: Color(0xff534F4F),
                fontFamily: 'Dosis',
                fontSize: 14,
              ),
            ),
            const ListTile(
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
                      fontFamily: 'Dosis',
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
            const ListTile(
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
                      fontFamily: 'Dosis',
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
            const ListTile(
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
                      fontFamily: 'Dosis',
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
            const Divider(
              color: Colors.grey,
            ),
            const Text(
              "Contact",
              style: TextStyle(
                color: Color(0xff534F4F),
                fontFamily: 'Dosis',
                fontSize: 14,
              ),
            ),
            const ListTile(
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
                      fontFamily: 'Dosis',
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
            const Divider(
              color: Colors.grey,
            ),
            const Text(
              "Log out",
              style: TextStyle(
                color: Color(0xff534F4F),
                fontFamily: 'Dosis',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: const Size(500, 50),
                backgroundColor: const Color(0xffF2AE00),
              ),
              child: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Dosis',
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
