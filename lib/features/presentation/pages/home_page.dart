import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/main_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/log_in_pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int? currentCursor;
  bool? hasNext;
  List<Post>? allPosts;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      hasNext != false
          ? context.read<PostProvider>().getAllPosts(currentCursor)
          : null;
    }
  }

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

    return RefreshIndicator(
      color: Color(0xffF2AE00),
      edgeOffset: 100,
      onRefresh: () => context.read<PostProvider>().refreshPosts(),
      child: FutureBuilder(
        future: context.read<PostProvider>().getAllPosts(null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xffF2AE00),
              ),
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SvgPicture.asset(
                  'assets/svgs/no_connection.svg',
                ),
              ),
            );
          }

          allPosts = context.watch<PostProvider>().allPostList!;
          currentCursor = context.watch<PostProvider>().cursor!;
          hasNext = context.watch<PostProvider>().hasNext;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                // physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    surfaceTintColor: Colors.white,
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
                  allPosts != null
                      ? SliverList.builder(
                          // addAutomaticKeepAlives: true,
                          // addRepaintBoundaries: true,
                          // addSemanticIndexes: true,
                          itemCount: allPosts!.length,
                          itemBuilder: (context, index) {
                            Post post = allPosts![index];
                            return MainPostCard(post: post);
                          },
                        )
                      : SliverToBoxAdapter(
                          child: Center(
                              child: Text("No Posts for You, You stupid fuck")),
                        ),
                  SliverToBoxAdapter(
                    child: hasNext == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffF2AE00),
                            ),
                          )
                        : Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultTextStyle(
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Dosis',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                      RotateAnimatedText(
                                          "Fuck , You've scrolled down to the end "),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
