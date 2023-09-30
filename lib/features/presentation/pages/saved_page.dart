import 'dart:developer';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/saved_pages/saved_posts_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: context.read<PostProvider>().getSavedPosts(),
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
          final savedPostList = context.watch<PostProvider>().savedPostList;
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
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
