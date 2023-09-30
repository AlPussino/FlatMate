import 'package:finding_apartments_yangon/core/utiles.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flat_description_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:page_transition/page_transition.dart';

class OtherUserPostCard extends StatefulWidget {
  final Post post;
  const OtherUserPostCard({super.key, required this.post});

  @override
  State<OtherUserPostCard> createState() => _OtherUserPostCardState();
}

class _OtherUserPostCardState extends State<OtherUserPostCard> {
  @override
  Widget build(BuildContext context) {
    final imageList = [];
    widget.post.pictures!.map((e) => imageList.add(e.url)).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 16),
          InkWell(
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
                    isOwnUserToSave: false,
                    isOwnUserToCall: false,
                    isOwnUserToShowContactCard: true,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 130,
              width: MediaQuery.sizeOf(context).width,
              child: Animate(
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
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Carousel(
                                autoScroll: true,
                                animationPageCurve: Curves.linear,
                                activateIndicatorColor: const Color(0xffF2AE00),
                                indicatorBarColor: Colors.transparent,
                                isCircle: false,
                                indicatorHeight: 0,
                                indicatorWidth: 0,
                                autoScrollDuration: Duration(seconds: 5),
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
                        ),
                      ),
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
                                        Icon(
                                          Icons.grid_view,
                                          color: Color(0xff534F4F),
                                          size: 15,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.post.apartment!.floor != 0
                                              ? "${widget.post.apartment!.apartmentType}   |   ${widget.post.apartment!.floor}th floor"
                                              : "${widget.post.apartment!.apartmentType}   |   Ground floor",
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
                                          Icons.location_on_outlined,
                                          color: Color(0xff534F4F),
                                          size: 15,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.post.township!,
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontSize: 12,
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
                                          Icons.map_rounded,
                                          color: Color(0xff534F4F),
                                          size: 15,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.post.state!,
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontSize: 12,
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Text(
                                              '${widget.post.price} /m',
                                              style: TextStyle(
                                                color: Color(0xff000000),
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
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${widget.post.tenants} left",
                                                style: TextStyle(
                                                  color: Color(0xffFFFFFF),
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
              ).animate().shimmer(
                    duration: Duration(seconds: 2),
                    color: Color.fromARGB(20, 242, 173, 0),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
