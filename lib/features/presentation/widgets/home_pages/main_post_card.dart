import 'package:finding_apartments_yangon/core/utiles.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flat_description_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:page_transition/page_transition.dart';

class MainPostCard extends StatefulWidget {
  final Post post;
  const MainPostCard({super.key, required this.post});

  @override
  State<MainPostCard> createState() => _MainPostCardState();
}

class _MainPostCardState extends State<MainPostCard> {
  @override
  Widget build(BuildContext context) {
    List<String> imageList = [];

    widget.post.pictures!.map((e) => imageList.add(e.url!)).toList();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          splashColor: Color(0xffF2AE00).withOpacity(0.4),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  fullscreenDialog: true,
                  childCurrent: Center(
                    child: CircularProgressIndicator(),
                  ),
                  type: PageTransitionType.rightToLeft,
                  child: FlatDescriptionPage(
                    id: widget.post.id!,
                  )),
            );
          },
          child: Animate(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 400,
              child: Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              child: Carousel(
                                autoScroll: false,
                                animationPageCurve: Curves.linear,
                                activateIndicatorColor: const Color(0xffF2AE00),
                                indicatorBarColor: Colors.transparent,
                                isCircle: false,
                                indicatorHeight: 2,
                                indicatorWidth: 20,
                                items: [
                                  ...widget.post.pictures!
                                      .map(
                                        (e) => Utils.headerImagesSlide(
                                            true,
                                            widget.post.pictures!,
                                            e.url ?? "",
                                            context),
                                      )
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Text(
                                                "${widget.post.price!} /m",
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${widget.post.tenants} left",
                                                    style: TextStyle(
                                                      color: Color(0xffFFFFFF),
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
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 15,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              widget.post.township!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        widget.post.apartment!.floor != 0
                                            ? "${widget.post.apartment!.floor}th floor"
                                            : "Ground floor",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.map_rounded,
                                              size: 15,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              widget.post.state!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.grid_view,
                                              size: 15,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              widget.post.apartment!
                                                  .apartmentType!,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ).animate().shimmer());
  }
}
