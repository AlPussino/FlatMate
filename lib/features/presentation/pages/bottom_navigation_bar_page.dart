import 'package:animations/animations.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/home_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/profile_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/saved_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/search_page.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/home_provider.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  final screens = [
    const HomePage(),
    const SearchPage(),
    const SavedPage(),
    const ProfilePage(),
  ];
  @override
  void initState() {
    bool isTokenExpired = context.read<AuthProvider>().isTokenExpired();
    isTokenExpired ? context.read<UserProvider>().getUserInfo() : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<HomeProvider>().currentIdx;
    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.white,
            title: const Text(
              'Are you sure you want to exit?',
              style: TextStyle(
                color: Color(0xff534F4F),
                fontFamily: 'Dosis',
                fontSize: 14,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "NO",
                  style: TextStyle(
                    color: Color(0xffF2AE00),
                    fontFamily: 'Dosis',
                    fontSize: 14,
                  ),
                ),
                onPressed: () => Navigator.of(context).maybePop(false),
              ),
              TextButton(
                child: const Text(
                  "YES",
                  style: TextStyle(
                    color: Color(0xffF2AE00),
                    fontFamily: 'Dosis',
                    fontSize: 14,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          ),
        );
        return confirm ? true : false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: PageTransitionSwitcher(
          transitionBuilder: (
            child,
            animation,
            secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: screens[currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xffF2AE00),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          onTap: (newIndex) {
            context.read<HomeProvider>().changePage(newIndex);
          },
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? const Color(0xffF2AE00)
                      : const Color(0xff666666),
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/svgs/home_icon.svg',
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? const Color(0xffF2AE00)
                      : const Color(0xff666666),
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/svgs/search_icon.svg',
                ),
              ),
              label: 'My Courses',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  currentIndex == 2
                      ? const Color(0xffF2AE00)
                      : const Color(0xff666666),
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/svgs/love_icon.svg',
                ),
              ),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? const Color(0xffF2AE00)
                      : const Color(0xff666666),
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  'assets/svgs/person_icon.svg',
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
