import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/flat_description_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyPostsCard extends StatelessWidget {
  final Post post;
  final List<dynamic> imgList;
  const MyPostsCard({super.key, required this.post, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        splashColor: Color(0xffF2AE00).withOpacity(0.4),
        onTap: () {
          log(post.id.toString());
          Navigator.push(
            context,
            PageTransition(
              fullscreenDialog: true,
              childCurrent: Center(
                child: CircularProgressIndicator(),
              ),
              type: PageTransitionType.rightToLeft,
              child: FlatDescriptionPage(
                isOwnUserToSave: true,
                isOwnUserToShowContactCard: true,
                isOwnUserToCall: true,
                id: post.id!,
              ),
            ),
          );
        },
        child: Animate(
          child: SizedBox(
            height: 130,
            width: MediaQuery.sizeOf(context).width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 0.5,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: imgList[0],
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
                            progressIndicatorBuilder: (context, url, progress) {
                              return Padding(
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
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.grid_view,
                                          color: Color(0xff534F4F),
                                          size: 15,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          post.apartment!.floor != 0
                                              ? "${post.apartment!.apartmentType.toString()}  |  ${post.apartment!.floor}th floor"
                                              : "${post.apartment!.apartmentType.toString()}  | Ground floor",
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
                                    PopupMenuButton<String>(
                                      child: Icon(Icons.more_vert),
                                      onSelected: (String choice) {
                                        switch (choice) {
                                          case 'Delete':
                                            context
                                                .read<PostProvider>()
                                                .deleteMyPost(post.id!);
                                            break;
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            value: 'Delete',
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.delete),
                                                SizedBox(width: 10),
                                                Text('Delete'),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'Edit',
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.edit),
                                                SizedBox(width: 10),
                                                Text('Edit'),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'Left',
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.people),
                                                SizedBox(width: 10),
                                                Text('Tenants left'),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
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
                                        "${post.township}",
                                        style: TextStyle(
                                          color: Color(0xff534F4F),
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
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.map_rounded,
                                      color: Color(0xff534F4F),
                                      size: 15,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${post.state}",
                                      style: TextStyle(
                                        color: Color(0xff534F4F),
                                        fontFamily: DefaultTextStyle.of(context)
                                            .style
                                            .fontFamily,
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
                              child: SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: SizedBox(
                                        child: Text(
                                          '${post.price}/m',
                                          maxLines: 2,
                                          softWrap: true,
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
                                    SizedBox(
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
    );
  }
}
