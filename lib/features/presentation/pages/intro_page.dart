import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/log_in_pages/login_page_1.dart';
import 'package:flutter/material.dart';
import 'package:animated_introduction/animated_introduction.dart';
import 'package:page_transition/page_transition.dart';

class IntroPage extends StatelessWidget {
  IntroPage({super.key});

  final List<SingleIntroScreen> pages = [
    SingleIntroScreen(
      imageWithBubble: true,
      title: 'Welcome to the Fucking App !',
      description:
          'You plans your Events, We\'ll do the rest and will be the best! Guaranteed!  ',
      textStyle: TextStyle(
        color: AppColor.whiteColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Dosis',
        fontSize: 18,
      ),
      imageAsset: 'assets/images/apartment.png',
    ),
    SingleIntroScreen(
      title: 'Book tickets to cricket matches and events',
      description:
          'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more !',
      textStyle: TextStyle(
        color: AppColor.whiteColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Dosis',
        fontSize: 18,
      ),
      imageAsset: 'assets/images/direction.png',
    ),
    const SingleIntroScreen(
      title: 'Grabs all events now only in your hands',
      description: 'All events are now in your hands, just a click away ! ',
      textStyle: TextStyle(
        color: AppColor.whiteColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Dosis',
        fontSize: 18,
      ),
      imageAsset: 'assets/images/house.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: AnimatedIntroduction(
          footerBgColor: AppColor.orangeColor,
          slides: pages,
          containerBg: AppColor.whiteColor,
          physics: BouncingScrollPhysics(),
          indicatorType: IndicatorType.line,
          footerRadius: 20,
          doneText: "Login",
          onDone: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: LogInPage()),
            );
          },
        ),
      ),
    );
  }
}
