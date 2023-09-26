import 'dart:developer';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flats_by_township_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/home_pages/post_card.dart';
import '../widgets/log_in_pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isTokenExpired = context.read<AuthProvider>().isTokenExpired();

    if (isTokenExpired) {
      final user = context.read<UserProvider>().getUserInfo();
      user.then((value) {
        if (value == null) {
          log("value : $value");
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight, child: LoginPage()),
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                centerTitle: false,
                title: Text(
                  "Find Your Stay",
                  style: TextStyle(
                    fontFamily: 'Dosis',
                    color: Color(0xffF2AE00),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hlaing",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: DefaultTextStyle.of(context)
                                      .style
                                      .fontFamily,
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const FlatsByTownshipPage()),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "see all",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: DefaultTextStyle.of(context)
                                            .style
                                            .fontFamily,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Color(0xff534F4F),
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PostCard(),
                                PostCard(),
                                PostCard(),
                                PostCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
