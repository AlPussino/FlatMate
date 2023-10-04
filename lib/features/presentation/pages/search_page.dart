import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/search_pages/searched_user_card.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/shimmers.dart/search_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _formKey = GlobalKey<FormState>();

  final _searchKeyController = TextEditingController();

  FocusNode searchKeyFocusNode = FocusNode();
  bool searchKeyError = false;
  late bool isLoading = false;

  @override
  void dispose() {
    _searchKeyController.dispose();
    searchKeyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: FutureBuilder(
          future: context.read<UserProvider>().searchUser(keyword: '.'),
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
            final postOwnerList = context.watch<UserProvider>().postOwnerList;
            return SafeArea(
              child: CustomScrollView(
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  cursorColor: AppColor.orangeColor,
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 14,
                                  ),
                                  controller: _searchKeyController,
                                  keyboardType: TextInputType.emailAddress,
                                  onEditingComplete: () async {
                                    await context
                                        .read<UserProvider>()
                                        .searchUser(
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
                                          color: AppColor.greyColor,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColor.greyColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColor.greyColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColor.greyColor,
                                        ),
                                      ),
                                      suffixIcon: _searchKeyController
                                              .text.isNotEmpty
                                          ? IconButton(
                                              onPressed: () {
                                                _searchKeyController.clear();
                                              },
                                              icon: Icon(Icons.close))
                                          : null),
                                  onFieldSubmitted: (value) {
                                    isLoading = true;

                                    Future.delayed(Duration(seconds: 1),
                                        () async {
                                      await context
                                          .read<UserProvider>()
                                          .searchUser(keyword: value);
                                      isLoading = false;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                    )),
                  ),
                  !isLoading
                      ? postOwnerList!.postOwners!.isNotEmpty
                          ? SliverList.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: postOwnerList.postOwners!.length,
                              itemBuilder: (context, index) {
                                final postOwner =
                                    postOwnerList.postOwners![index];
                                return SearchedUserCard(postOwner: postOwner);
                              },
                            )
                          : SliverToBoxAdapter(
                              child: Center(child: Text('')),
                            )
                      : SliverList.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SearchLoadingShimmer();
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
