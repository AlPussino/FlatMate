import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/home_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/saved_pages/saved_posts_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: FutureBuilder(
        future: context.read<PostProvider>().getSavedPosts(),
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
          final savedPostList = context.watch<PostProvider>().savedPostList;

          final ScrollController _scrollController = ScrollController();

          void _onScroll() {
            if (_scrollController.position.userScrollDirection ==
                ScrollDirection.reverse) {
              log('scrolling down');
              context.read<HomeProvider>().hideAndShowNavigationBar(true);
              log("${context.read<HomeProvider>().showBottomNavigationBar}");
            } else if (_scrollController.position.userScrollDirection ==
                ScrollDirection.forward) {
              log('scrolling up');
              context.read<HomeProvider>().hideAndShowNavigationBar(false);
              log("${context.read<HomeProvider>().showBottomNavigationBar}");
            } else {
              null;
            }
          }

          _scrollController.addListener(_onScroll);
          return SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  surfaceTintColor: AppColor.whiteColor,
                  backgroundColor: AppColor.whiteColor,
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
                      "Saved",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                savedPostList != null
                    ? savedPostList.posts!.isNotEmpty
                        ? SliverPadding(
                            padding: EdgeInsets.only(top: 8),
                            sliver: SliverList.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: savedPostList.posts!.length,
                              itemBuilder: (context, index) {
                                final post = savedPostList.posts![index];
                                return SavedPostsCard(post: post);
                              },
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: Center(
                              child: Text("No Saved Posts !"),
                            ),
                          )
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No saved Posts List, PostList is null",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Dude , I'm sure You don't know how to save post You stupid Fucker",
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
    );
  }
}
