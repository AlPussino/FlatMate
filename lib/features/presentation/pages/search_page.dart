import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner_list.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/search_pages/searched_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();

  final _searchKeyController = TextEditingController();
  FocusNode searchKeyFocusNode = FocusNode();
  bool searchKeyError = false;
  late bool isLoading = false;
  bool _showError = false;

  @override
  void dispose() {
    _searchKeyController.dispose();
    searchKeyFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   foregroundColor: Colors.black,
        //   title: Text(
        //     "Search",
        //     style: TextStyle(
        //       color: Color(0xff000000),
        //       fontWeight: FontWeight.bold,
        //       fontSize: 24,
        //     ),
        //   ),
        // ),
        // body: Column(
        //   children: [
        //     SizedBox(
        //       width: MediaQuery.sizeOf(context).width,
        //       child: TextLiquidFill(
        //         text: 'Search',
        //         waveColor: Colors.blueAccent,
        //         boxBackgroundColor: Colors.white,
        //         textStyle: TextStyle(
        //           fontSize: 80.0,
        //           fontWeight: FontWeight.bold,
        //           fontFamily: DefaultTextStyle.of(context).style.fontFamily,
        //         ),
        //         boxHeight: 300.0,
        //         loadDuration: Duration(seconds: 1),
        //       ),
        //     ),
        //     Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         DefaultTextStyle(
        //           textAlign: TextAlign.start,
        //           style: TextStyle(
        //             fontSize: 40.0,
        //             fontFamily: DefaultTextStyle.of(context).style.fontFamily,
        //             color: Colors.black,
        //           ),
        //           child: AnimatedTextKit(
        //             isRepeatingAnimation: true,
        //             animatedTexts: [
        //               RotateAnimatedText("I don't know"),
        //               RotateAnimatedText("how to code"),
        //               RotateAnimatedText('Search Page'),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),

        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: context.read<UserProvider>().searchUser(keyword: '.'),
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
            final postOwnerList = context.watch<UserProvider>().postOwnerList;
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
                        "Search",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(20),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              cursorColor: Color(0xffF2AE00),
                              style: TextStyle(
                                color: Color(0xff2E2E2E),
                                fontSize: 14,
                              ),
                              controller: _searchKeyController,
                              keyboardType: TextInputType.emailAddress,
                              onEditingComplete: () async {
                                await context.read<UserProvider>().searchUser(
                                    keyword: _searchKeyController.text);
                                return log('Tap');
                              },
                              focusNode: searchKeyFocusNode,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                              ),
                              onChanged: (value) async {
                                await context
                                    .read<UserProvider>()
                                    .searchUser(keyword: value);
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Search results",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: postOwnerList!.postOwners!.length,
                    itemBuilder: (context, index) {
                      final postOwner = postOwnerList.postOwners![index];
                      return SearchedUserCard(postOwner: postOwner);
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }

  bool isSearchKeyValid(String name) {
    return name.isNotEmpty;
  }
}
