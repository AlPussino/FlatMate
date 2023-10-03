import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flat_description_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/utils/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:page_transition/page_transition.dart';

class MainPostCard extends StatelessWidget {
  final Post post;
  const MainPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [];
    post.pictures!.map((e) => imageList.add(e.url!)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
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
                  isOwnUserToShowContactCard: false,
                  isOwnUserToSave: false,
                  isOwnUserToCall: false,
                  id: post.id!,
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
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            child: Carousel(
                              autoScroll: false,
                              animationPageCurve: Curves.linear,
                              activateIndicatorColor: const Color(0xffF2AE00),
                              indicatorBarColor: Colors.transparent,
                              isCircle: false,
                              indicatorHeight: 2,
                              indicatorWidth: 20,
                              items: [
                                ...post.pictures!
                                    .map(
                                      (e) => Utils.headerImagesSlide(true,
                                          post.pictures!, e.url ?? "", context),
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
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        child: Text(
                                          "${post.price!} /m",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${post.tenants} left",
                                              style: TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontFamily:
                                                    DefaultTextStyle.of(context)
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
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            post.township!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      post.apartment!.floor != 0
                                          ? "${post.apartment!.floor}th floor"
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
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.map_rounded,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            post.state!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.grid_view,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            post.apartment!.apartmentType!,
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
      ).animate().shimmer(
            duration: Duration(seconds: 2),
            color: Color.fromARGB(20, 242, 173, 0),
          ),
    );
  }
}
