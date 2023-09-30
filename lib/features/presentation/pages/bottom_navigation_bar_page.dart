import 'dart:async';
import 'dart:developer';
import 'package:animations/animations.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/home_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/profile_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/saved_page.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/search_page.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/create_post_pages/flat_create_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:overlay_support/overlay_support.dart';
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
    bool isTokenExpired = context.read<AuthProvider>().isTokenExpired();
    isTokenExpired ? context.read<UserProvider>().getUserInfo() : null;
    load();

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

  Future<void> load() async {
    await context.read<PostProvider>().loadMyanmarData();
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
        bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.white,
            title: Text(
              'Are you sure you want to exit?',
              style: TextStyle(
                color: Color(0xff534F4F),
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "NO",
                  style: TextStyle(
                    color: Color(0xffF2AE00),
                    fontSize: 14,
                  ),
                ),
                onPressed: () => Navigator.of(context).maybePop(false),
              ),
              TextButton(
                child: Text(
                  "YES",
                  style: TextStyle(
                    color: Color(0xffF2AE00),
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
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
          useLegacyColorScheme: true,
          backgroundColor: Colors.white,
          mouseCursor: MouseCursor.uncontrolled,
          currentIndex: currentIndex,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xffF2AE00),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          onTap: (newIndex) {
            context.read<PostProvider>().clearPostList();
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
              tooltip: 'Explore',
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
              label: 'Search',
              tooltip: 'Search',
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
                  'assets/svgs/add_icon.svg',
                ),
              ),
              label: 'Post',
              tooltip: 'Post',
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
                  'assets/svgs/love_icon.svg',
                ),
              ),
              label: 'Saved',
              tooltip: 'Saved',
            ),
            BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    currentIndex == 4
                        ? const Color(0xffF2AE00)
                        : const Color(0xff666666),
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/person_icon.svg',
                  ),
                ),
                label: 'Profile',
                tooltip: 'Profile'),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   foregroundColor: Colors.white,
        //   elevation: 2,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //   backgroundColor: Color(0xffF2AE00),
        //   enableFeedback: true,
        //   isExtended: true,
        //   onPressed: () async {
        //     // final List<XFile?> image = await picker.pickMultiImage();
        //     Navigator.push(
        //       context,
        //       PageTransition(
        //           type: PageTransitionType.rightToLeft,
        //           child: const FlatCreatePost()),
        //     );
        //   },
        //   tooltip: 'Add Item',
        //   child: const Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
