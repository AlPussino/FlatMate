import 'package:finding_apartments_yangon/core/utiles.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flat_description_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:page_transition/page_transition.dart';

class SavedPostsCard extends StatefulWidget {
  final Post post;
  const SavedPostsCard({super.key, required this.post});

  @override
  State<SavedPostsCard> createState() => _SavedPostsCardState();
}

class _SavedPostsCardState extends State<SavedPostsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      isOwnUserToSave: false,
                      isOwnUserToCall: false,
                      isOwnUserToShowContactCard: false,
                    )),
              );
            },
            child: Animate(
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
                                              ? "${widget.post.apartment!.apartmentType}  |  ${widget.post.apartment!.floor}th floor"
                                              : "${widget.post.apartment!.apartmentType}  |  Ground floor",
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontFamily:
                                                DefaultTextStyle.of(context)
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
                                            "${widget.post.township}  |  ${widget.post.state}",
                                            style: TextStyle(
                                              color: Color(0xff534F4F),
                                              fontFamily:
                                                  DefaultTextStyle.of(context)
                                                      .style
                                                      .fontFamily,
                                              fontSize: 12,
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
                                          "${widget.post.postOwner!.mobileNumber}",
                                          style: TextStyle(
                                            color: Color(0xff534F4F),
                                            fontFamily:
                                                DefaultTextStyle.of(context)
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
                                                fontFamily:
                                                    DefaultTextStyle.of(context)
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
            ).animate().shimmer(
                  duration: Duration(seconds: 2),
                  color: Color.fromARGB(20, 242, 173, 0),
                ),
          ),
        ),
      ],
    );
  }
}
