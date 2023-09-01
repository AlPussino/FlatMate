import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'flat_description_page.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        splashColor: Color(0xffF2AE00).withOpacity(0.4),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const FlatDescriptionPage()),
          );
        },
        child: SizedBox(
          width: 200,
          height: 250,
          child: Card(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://cdn.pixabay.com/photo/2016/10/18/09/02/hotel-1749602_1280.jpg",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.only(
                              top: 60, right: 20, bottom: 60, left: 20),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: const CircularProgressIndicator(
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "100000/m",
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: 'Dosis',
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                          color: Color(0xff534F4F),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Hlaing, Yangon",
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontFamily: 'Dosis',
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.phone,
                                          size: 15,
                                          color: Color(0xff534F4F),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "09-987654321",
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontFamily: 'Dosis',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "3 left",
                                        style: TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontFamily: 'Dosis',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
        ),
      ),
    );
  }
}
