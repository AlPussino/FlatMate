import 'dart:developer';
import 'package:animated_icon/animated_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/presentation/pages/setting_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/create_post_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final ImagePicker picker = ImagePicker();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
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
                  // background: Image.asset(
                  //   "assets/images/rick.jpg",
                  //   fit: BoxFit.cover,
                  // ),
                ),
                actions: [
                  AnimateIcon(
                    toolTip: 'Setting',
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: const SettingPage()),
                      );
                    },
                    iconType: IconType.animatedOnTap,
                    height: 70,
                    width: 70,
                    color: Color(0xff000000),
                    animateIcon: AnimateIcons.settings,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.sizeOf(context).width,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: const Color.fromARGB(255, 226, 226, 226),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 53,
                                  backgroundColor: Color(0xffF2AE00),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
                                    imageBuilder: (context, imageProvider) =>
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
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff534F4F)
                                                  .withOpacity(0.5),
                                            ),
                                            child: const Icon(Icons.error)),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Oak The Gay",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: 'Dosis',
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "09-87654321",
                                        style: TextStyle(
                                          color: Color(0xff534F4F),
                                          fontFamily: 'Dosis',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "oakoakthegay69@gaymail.com",
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
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Padding(
                                            padding: const EdgeInsets.only(
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
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
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
                                                        color:
                                                            Color(0xff534F4F),
                                                        size: 15,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "Condo | 2 floor",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff534F4F),
                                                          fontFamily: 'Dosis',
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
                                                      child: Icon(
                                                          Icons.more_vert)),
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
                                                    color: Color(0xff534F4F),
                                                    size: 15,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      "South Oakalapa | Yangon",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff534F4F),
                                                        fontFamily: 'Dosis',
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
                                                    color: Color(0xff534F4F),
                                                    size: 15,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "09-987654321",
                                                    style: TextStyle(
                                                      color: Color(0xff534F4F),
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
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2),
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Text(
                                                        '1000000/m',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff000000),
                                                          fontFamily: 'Dosis',
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
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "3 left",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffFFFFFF),
                                                            fontFamily: 'Dosis',
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
                child: const CreatePostPage()),
          );
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
