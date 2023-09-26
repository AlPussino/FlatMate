import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
                title: Text(
                  "Saved",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 8),
              sliver: SliverList.list(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                        color:
                                                            Color(0xff534F4F),
                                                        fontFamily:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style
                                                                .fontFamily,
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
                                                          fontFamily:
                                                              DefaultTextStyle.of(
                                                                      context)
                                                                  .style
                                                                  .fontFamily,
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
                                                        color:
                                                            Color(0xff534F4F),
                                                        fontFamily:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style
                                                                .fontFamily,
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
                                                        color:
                                                            Colors.transparent,
                                                        child: Text(
                                                          '1000000/m',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                DefaultTextStyle.of(
                                                                        context)
                                                                    .style
                                                                    .fontFamily,
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
                                                              fontFamily:
                                                                  DefaultTextStyle.of(
                                                                          context)
                                                                      .style
                                                                      .fontFamily,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
