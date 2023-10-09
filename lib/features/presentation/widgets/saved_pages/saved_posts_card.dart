import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flat_description_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SavedPostsCard extends StatelessWidget {
  final Post post;
  const SavedPostsCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final imgList = [];
    post.pictures!.map((e) => imgList.add(e.url)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            splashColor: AppColor.orangeColor,
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
                      id: post.id!,
                      isOwnUserToSave: false,
                      isOwnUserToCall: false,
                      isOwnUserToShowContactCard: false,
                    )),
              );
            },
            child: SizedBox(
              height: 130,
              width: MediaQuery.sizeOf(context).width,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColor.cardBackgroundColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Center(
                            // child: Carousel(
                            //   autoScroll: true,
                            //   animationPageCurve: Curves.linear,
                            //   activateIndicatorColor: const AppColor.orangeColor,
                            //   indicatorBarColor: AppColor.transparent,
                            //   isCircle: false,
                            //   indicatorHeight: 0,
                            //   indicatorWidth: 0,
                            //   autoScrollDuration: Duration(seconds: 5),
                            //   items: [
                            //     ...widget.post.pictures!
                            //         .map(
                            //           (e) => Utils.headerImagesSlide(
                            //               true,
                            //               widget.post.pictures!,
                            //               e.url ?? "",
                            //               context),
                            //         )
                            //         .toList(),
                            //   ],
                            // ),
                            child: CachedNetworkImage(
                              imageUrl: imgList[0],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                double? progress = downloadProgress.progress;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 60, right: 20, bottom: 60, left: 20),
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      value: progress,
                                      color: AppColor.orangeColor,
                                      backgroundColor: AppColor.whiteColor,
                                    ),
                                  ),
                                );
                              },
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
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: AppColor.transparent,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.grid_view,
                                        color: AppColor.greyColor,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        post.apartment!.floor != 0
                                            ? "${post.apartment!.apartmentType}  |  ${post.apartment!.floor}th floor"
                                            : "${post.apartment!.apartmentType}  |  Ground floor",
                                        style: TextStyle(
                                          color: AppColor.greyColor,
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
                                  color: AppColor.transparent,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: AppColor.greyColor,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "${post.township}  |  ${post.state}",
                                          style: TextStyle(
                                            color: AppColor.greyColor,
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
                                  color: AppColor.transparent,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColor.greyColor,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${post.postOwner!.mobileNumber}",
                                        style: TextStyle(
                                          color: AppColor.greyColor,
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
                                  color: AppColor.transparent,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Container(
                                          color: AppColor.transparent,
                                          child: Text(
                                            '${post.price} /m',
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
                                        color: AppColor.whiteColor,
                                        child: Container(
                                          height: 25,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: AppColor.blackColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${post.tenants} left",
                                              style: TextStyle(
                                                color: AppColor.whiteColor,
                                                fontFamily:
                                                    DefaultTextStyle.of(context)
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
    );
  }
}
