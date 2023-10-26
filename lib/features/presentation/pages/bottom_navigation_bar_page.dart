import 'dart:async';
import 'dart:developer';
import 'package:animations/animations.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/home_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/bottom_navigation_bar_pages/bottom_navigation_bar_widgets/bottom_navigation_bar_item.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/create_post_pages/flat_create_post.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'pages.dart';

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
    const FlatCreatePost(isEdit: false),
    const SavedPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
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
            context.read<HomeProvider>().hideAndShowNavigationBar(false);
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
            // return ScaleTransition(
            //   scale: CurvedAnimation(
            //       parent: animation, curve: Curves.fastEaseInToSlowEaseOut),
            //   child: child,
            // );
          },
          child: screens[currentIndex],
        ),
        bottomNavigationBar: AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: Visibility(
            visible: !context.watch<HomeProvider>().showBottomNavigationBar,
            child: BottomNavigationBar(
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
        ),
        floatingActionButton: AnimatedSize(
          curve: Curves.fastEaseInToSlowEaseOut,
          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          reverseDuration: Duration(milliseconds: 300),
          child: Visibility(
            visible: !context.watch<HomeProvider>().showBottomNavigationBar,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: FlatCreatePost(isEdit: false)),
                );
              },
              child: Icon(
                Icons.add,
                color: AppColor.whiteColor,
              ),
              backgroundColor: AppColor.orangeColor,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void scrollUpAndRefreshPosts() {
    context.read<HomeProvider>().scrollUpToTheStart();
    context.read<PostProvider>().refreshPosts();
  }
}
