import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostOwnerProfilePage extends StatefulWidget {
  const PostOwnerProfilePage({super.key});

  @override
  State<PostOwnerProfilePage> createState() => _PostOwnerProfilePageState();
}

class _PostOwnerProfilePageState extends State<PostOwnerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              foregroundColor: Colors.black,
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 50,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(0),
                centerTitle: false,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Aung Khant Kyaw",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                  color: Color(0xff534F4F),
                                ),
                                Text(
                                  "09-87654321",
                                  style: TextStyle(
                                    color: Color(0xff534F4F),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/facebook_logo.svg',
                                ),
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/svgs/instagram_logo.svg',
                                ),
                              ],
                            ),
                          ],
                        ),
                        CachedNetworkImage(
                          imageUrl:
                              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
                          imageBuilder: (context, imageProvider) => Container(
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
                          errorWidget: (context, url, error) => Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff534F4F).withOpacity(0.5),
                              ),
                              child: const Icon(Icons.error)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Posts",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        splashColor: Color(0xffF2AE00).withOpacity(0.4),
                        onTap: () {
                          log('Tap Tap');
                        },
                        child: SizedBox(
                          height: 130,
                          width: MediaQuery.sizeOf(context).width,
                          child: Card(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: Colors.transparent,
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
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.grid_view,
                                                    color: Color(0xff534F4F),
                                                    size: 15,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "Condo | 2 floor",
                                                    style: TextStyle(
                                                      color: Color(0xff534F4F),
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.aspect_ratio_rounded,
                                                    color: Color(0xff534F4F),
                                                    size: 15,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "15 x 80 square feet",
                                                    style: TextStyle(
                                                      color: Color(0xff534F4F),
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              color: Colors.transparent,
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
                                              color: Colors.transparent,
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
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        '1000000/m',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff000000),
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.transparent,
                                                    child: Container(
                                                      height: 25,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "3 left",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffFFFFFF),
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
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
