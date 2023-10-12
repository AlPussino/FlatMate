import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/intro_page.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_bar_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final navigator = Navigator.of(context);
        final result = await context.read<AuthProvider>().isAuthenticated();
        log('isAuthenticated : $result');
        if (result) {
          navigator.pushReplacement(
            MaterialPageRoute(
                settings: const RouteSettings(name: 'home'),
                builder: (context) => const BottomNavigationBarPage()),
          );
        } else {
          navigator.pushReplacement(
            MaterialPageRoute(
                settings: const RouteSettings(name: 'home'),
                builder: (context) => IntroPage()),
          );
        }
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashImg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 24),
                  child: RichText(
                    textWidthBasis: TextWidthBasis.longestLine,
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 48,
                        fontFamily: 'Dosis',
                      ),
                      children: [
                        TextSpan(
                          text: 'FIND\n',
                        ),
                        TextSpan(
                          text: 'YOUR\n',
                        ),
                        TextSpan(
                          text: 'STAY\n',
                        ),
                        TextSpan(
                          text: 'Apartments and Hostels in Yangon',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Visibility(
                    visible: false,
                    child: DottedBorder(
                      color: AppColor.greyColor,
                      dashPattern: const [20, 20],
                      borderType: BorderType.Circle,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: DottedBorder(
                            color: AppColor.greyColor,
                            dashPattern: const [20, 20],
                            borderType: BorderType.Circle,
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    backgroundColor: AppColor.blackColor,
                                    radius: 30,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
