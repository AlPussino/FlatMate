import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/setting_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/create_post_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/log_in_pages/login_page.dart';
import '../widgets/profile_pages/create_post.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final ImagePicker picker = ImagePicker();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    log('build');
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
      body: RefreshIndicator(
        onRefresh: () => _refreshAccounts(),
        color: Color(0xffF2AE00),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: context.read<UserProvider>().getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffF2AE00),
                  ),
                );
              }
              if (snapshot.hasError) {
                log(snapshot.error.toString());
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'Dosis',
                      fontSize: 20,
                    ),
                  ),
                );
              }
              final myUser = context.watch<UserProvider>().user;
              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      pinned: true,
                      elevation: 1,
                      automaticallyImplyLeading: false,
                      snap: false,
                      floating: false,
                      expandedHeight: 100,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding:
                            const EdgeInsets.only(left: 16, bottom: 16),
                        centerTitle: false,
                        title: const Text(
                          "Profile",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: 'Dosis',
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
                                    child: const SettingPage()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.sizeOf(context).width,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            splashColor: Color(0xffF2AE00).withOpacity(0.4),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const EditProfilePage()),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 53,
                                          backgroundColor: Color(0xffF2AE00),
                                          child: CachedNetworkImage(
                                            imageUrl: myUser!.profileUrl ??
                                                "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(
                                              color: Color(0xffF2AE00),
                                              backgroundColor: Colors.white,
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xff534F4F)
                                                          .withOpacity(0.5),
                                                    ),
                                                    child: const Icon(
                                                        Icons.error)),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                myUser.username ?? "",
                                                style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontFamily: 'Dosis',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                myUser.mobileNumber ?? "",
                                                style: TextStyle(
                                                  color: Color(0xff534F4F),
                                                  fontFamily: 'Dosis',
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                myUser.email ?? "",
                                                style: TextStyle(
                                                  color: Color(0xff534F4F),
                                                  fontFamily: 'Dosis',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: 8),
                      sliver: SliverList.list(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              splashColor: Color(0xffF2AE00).withOpacity(0.4),
                              onTap: () {
                                log('Tap Tap');
                              },
                              child: SizedBox(
                                height: 130,
                                width: MediaQuery.sizeOf(context).width,
                                child: Card(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: Center(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://cdn.pixabay.com/photo/2016/10/18/09/02/hotel-1749602_1280.jpg",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 60,
                                                          right: 20,
                                                          bottom: 60,
                                                          left: 20),
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: Color(0xffF2AE00),
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.grid_view,
                                                              color: Color(
                                                                  0xff534F4F),
                                                              size: 15,
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              "Condo | 2 floor",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff534F4F),
                                                                fontFamily:
                                                                    'Dosis',
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                            ),
                                                          ],
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              log('edit tap');
                                                            },
                                                            child: Icon(Icons
                                                                .more_vert)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color:
                                                              Color(0xff534F4F),
                                                          size: 15,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Text(
                                                            "South Oakalapa | Yangon",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff534F4F),
                                                              fontFamily:
                                                                  'Dosis',
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.phone,
                                                          color:
                                                              Color(0xff534F4F),
                                                          size: 15,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          "09-987654321",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff534F4F),
                                                            fontFamily: 'Dosis',
                                                            fontSize: 14,
                                                          ),
                                                          maxLines: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2),
                                                          child: Container(
                                                            color: Colors.white,
                                                            child: Text(
                                                              '1000000/m',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'Dosis',
                                                                fontSize: 22,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          color: Colors.white,
                                                          child: Container(
                                                            height: 25,
                                                            width: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                "3 left",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xffFFFFFF),
                                                                  fontFamily:
                                                                      'Dosis',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xffF2AE00),
        enableFeedback: true,
        isExtended: true,
        onPressed: () async {
          // final List<XFile?> image = await picker.pickMultiImage();
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const CreatePost()),
          );
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Future<void> _refreshAccounts() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      context.read<UserProvider>().getUserInfo();
    });
  }
}
