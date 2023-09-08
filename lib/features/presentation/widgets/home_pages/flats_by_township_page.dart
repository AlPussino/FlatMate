import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FlatsByTownshipPage extends StatefulWidget {
  const FlatsByTownshipPage({super.key});

  @override
  State<FlatsByTownshipPage> createState() => _FlatsByTownshipPageState();
}

class _FlatsByTownshipPageState extends State<FlatsByTownshipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: const Text(
          "Hlaing",
          style: TextStyle(
            color: Color(0xff000000),
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
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
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.houseboat_sharp,
                                      color: Color(0xff534F4F),
                                      size: 15,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Condo",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: 'Dosis',
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "|",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: 'Dosis',
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "2 floor",
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
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.area_chart_rounded,
                                      color: Color(0xff534F4F),
                                      size: 15,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "17",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: 'Dosis',
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "x",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: 'Dosis',
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "80",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: 'Dosis',
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "square feet",
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Container(
                                        color: Colors.white,
                                        child: Text(
                                          '1000000/m',
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: 'Dosis',
                                            fontSize: 18,
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
                                              BorderRadius.circular(20),
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
    );
  }
}
