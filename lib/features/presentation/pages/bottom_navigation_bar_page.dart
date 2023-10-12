import 'dart:async';
import 'dart:developer';
import 'package:animations/animations.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/home_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/profile_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/saved_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/search_page.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/log_in_providers/log_in_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/bottom_navigation_bar_pages/bottom_navigation_bar_widgets/bottom_navigation_bar_item.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/create_post_pages/flat_create_post.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;
  bool firstTimeConnected = true;

  final screens = [
    const HomePage(),
    const SearchPage(),
    const FlatCreatePost(),
    const SavedPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    context.read<LogInProvider>().restartLogInProvider();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
        List<String> parts = _connectionStatus.toString().split('.');
        if (status == InternetStatus.disconnected) {
          toast(parts[1]);
        } else {
          if (firstTimeConnected) {
            null;
            firstTimeConnected = false;
          } else {
            toast(parts[1]);
          }
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<HomeProvider>().currentIdx;
    log(_connectionStatus.toString());

    return WillPopScope(
      onWillPop: () async {
        // bool confirm = await showDialog(
        //   context: context,
        //   builder: (context) => ExitConfirmationDialog(),
        // );
        if (currentIndex == 0) {
          bool? result = context.read<HomeProvider>().isListAtTop();
          log(result.toString());

          if (result == true) {
            return true;
          } else {
            context.read<HomeProvider>().scrollUpToTheStart();
            return false;
          }
        } else {
          return true;
        }
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
          useLegacyColorScheme: true,
          backgroundColor: AppColor.whiteColor,
          mouseCursor: MouseCursor.uncontrolled,
          currentIndex: currentIndex,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.orangeColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          onTap: (newIndex) {
            context.read<HomeProvider>().changePage(newIndex);
            currentIndex != 0
                ? context.read<PostProvider>().clearAllPostList()
                : scrollUpAndRefreshPosts();
          },
          items: [
            BottomNavigationBarItems.bottomNavigationBarItem(
                currentIndex, 0, 'assets/svgs/home_icon.svg', 'Explore'),
            BottomNavigationBarItems.bottomNavigationBarItem(
                currentIndex, 1, 'assets/svgs/search_icon.svg', 'Search'),
            BottomNavigationBarItems.bottomNavigationBarItem(
                currentIndex, 2, 'assets/svgs/add_icon.svg', 'Post'),
            BottomNavigationBarItems.bottomNavigationBarItem(
                currentIndex, 3, 'assets/svgs/love_icon.svg', 'Saved'),
            BottomNavigationBarItems.bottomNavigationBarItem(
                currentIndex, 4, 'assets/svgs/person_icon.svg', 'Profile'),
          ],
        ),
      ),
    );
  }

  void scrollUpAndRefreshPosts() {
    context.read<HomeProvider>().scrollUpToTheStart();
    context.read<PostProvider>().refreshPosts();
  }
}
