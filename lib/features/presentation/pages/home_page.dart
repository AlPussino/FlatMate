import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/home_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/main_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ScrollController _scrollController = ScrollController();
  int? currentCursor;
  bool? hasNext;
  List<Post>? allPosts;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().saveController(_scrollController);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      hasNext != false
          ? context.read<PostProvider>().getAllPosts(currentCursor)
          : null;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      context.read<HomeProvider>().hideAndShowNavigationBar(true);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      context.read<HomeProvider>().hideAndShowNavigationBar(false);
    } else {
      null;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      color: AppColor.orangeColor,
      edgeOffset: 100,
      onRefresh: () => context.read<PostProvider>().refreshPosts(),
      child: FutureBuilder(
        future: context.read<PostProvider>().getAllPosts(null),
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

          allPosts = context.watch<PostProvider>().allPostList!;
          currentCursor = context.watch<PostProvider>().cursor!;
          hasNext = context.watch<PostProvider>().hasNext;

          return Scaffold(
            backgroundColor: AppColor.whiteColor,
            body: SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    surfaceTintColor: AppColor.whiteColor,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: AppColor.whiteColor,
                    pinned: false,
                    snap: false,
                    floating: true,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                      centerTitle: false,
                      title: InkWell(
                        splashColor: AppColor.transparent,
                        onTap: () {
                          context.read<HomeProvider>().scrollUpToTheStart();
                        },
                        child: Text(
                          "Find Your Stay",
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: AppColor.orangeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  allPosts != null
                      ? SliverList.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          addSemanticIndexes: false,
                          itemCount: allPosts!.length,
                          itemBuilder: (context, index) {
                            final post = allPosts![index];
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
                              color: AppColor.orangeColor,
                            ),
                          )
                        : Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // DefaultTextStyle(
                                //   textAlign: TextAlign.start,
                                //   style: TextStyle(
                                //     fontFamily: 'Dosis',
                                //     fontSize: 14,
                                //     color: AppColor.blackColor,
                                //   ),
                                //   child: AnimatedTextKit(
                                //     isRepeatingAnimation: false,
                                //     animatedTexts: [
                                //       RotateAnimatedText(
                                //           "Fuck , You've scrolled down to the end "),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text("Harder, Faster and Deeper ! "),
                                )
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
