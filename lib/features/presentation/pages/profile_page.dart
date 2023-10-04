import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/my_user.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/setting_page.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/token_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/my_posts_card.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/my_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/log_in_pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTokenExpired = context.read<TokenProvider>().isTokenExpired();

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
    Future<MyUser?> fetchMyUserInfo() async {
      final myData = await context.read<UserProvider>().getUserInfo();
      return myData;
    }

    Future<PostList?> fetchMyPosts() async {
      final myPosts = await context.read<PostProvider>().getMyPosts();
      return myPosts;
    }

    return Scaffold(
      body: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: FutureBuilder(
          future: Future.wait([fetchMyUserInfo(), fetchMyPosts()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.orangeColor,
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

            final myUser = context.watch<UserProvider>().user;
            final myPosts = context.watch<PostProvider>().myPostList;

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColor.whiteColor,
                    surfaceTintColor: AppColor.whiteColor,
                    pinned: true,
                    elevation: 1,
                    automaticallyImplyLeading: false,
                    snap: false,
                    floating: false,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                      centerTitle: false,
                      title: Text(
                        "Profile",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: SettingPage()),
                            );
                          },
                          icon: Icon(
                            Icons.settings,
                            color: AppColor.blackColor,
                          ))
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: MyProfileCard(myUser: myUser!),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Posts",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  myPosts != null
                      ? SliverList.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: myPosts.posts!.length,
                          itemBuilder: (context, index) {
                            final post = myPosts.posts![index];
                            final imgList = [];
                            post.pictures!
                                .map(
                                  (e) => imgList.add(e.url!),
                                )
                                .toList();

                            return MyPostsCard(post: post, imgList: imgList);
                          },
                        )
                      : SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "No Posts",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Dude , I'm sure You don't know how to post You stupid Fucker",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
