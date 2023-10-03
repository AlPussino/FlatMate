import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/post_owner_profile_page.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/utils/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FlatDescriptionPage extends StatelessWidget {
  final int id;
  final bool isOwnUserToSave;
  final bool isOwnUserToShowContactCard;
  final bool isOwnUserToCall;
  const FlatDescriptionPage({
    super.key,
    required this.id,
    required this.isOwnUserToSave,
    required this.isOwnUserToShowContactCard,
    required this.isOwnUserToCall,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<PostProvider>().getPostDetail(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xffF2AE00),
            ),
          );
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SvgPicture.asset(
                'assets/svgs/no_connection.svg',
              ),
            ),
          );
        }
        Post? postDetail = context.watch<PostProvider>().postDetail;
        log(postDetail!.isSaved.toString());
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            forceMaterialTransparency: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: !isOwnUserToSave
                    ? IconButton(
                        onPressed: () async {
                          !postDetail.isSaved!
                              ? await context
                                  .read<PostProvider>()
                                  .saveOrUnsavePost(id, true)
                              : await context
                                  .read<PostProvider>()
                                  .saveOrUnsavePost(id, false);
                        },
                        icon: Icon(
                          postDetail.isSaved == false
                              ? Icons.favorite_border
                              : Icons.favorite,
                          color: Color(0xffF2AE00),
                        ),
                      )
                    : null,
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 300,
                        child: Carousel(
                          autoScroll: false,
                          animationPageCurve: Curves.linear,
                          activateIndicatorColor: const Color(0xffF2AE00),
                          indicatorBarColor: Colors.transparent,
                          isCircle: false,
                          indicatorHeight: 2,
                          indicatorWidth: 20,
                          items: [
                            ...postDetail.pictures!
                                .map(
                                  (e) => Utils.headerImagesSlide(
                                      false,
                                      postDetail.pictures!,
                                      e.url ?? "",
                                      context),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                color: Color(0xff534F4F),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${postDetail.township}  |  ${postDetail.state} ",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${postDetail.additional}",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 20),
                            Text(
                              "Contract",
                              style: TextStyle(
                                color: Color(0xff534F4F),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              postDetail.contract!,
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 20),
                            Text(
                              "Flat type",
                              style: TextStyle(
                                color: Color(0xff534F4F),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  postDetail.apartment!.floor != 0
                                      ? "${postDetail.apartment!.apartmentType}  |  ${postDetail.apartment!.floor}th floor  |  ${postDetail.apartment!.length} x ${postDetail.apartment!.width} square feet"
                                      : "${postDetail.apartment!.apartmentType}  |  Ground floor  |  ${postDetail.apartment!.length} x ${postDetail.apartment!.width} square feet",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 20),
                            Text(
                              "Left",
                              style: TextStyle(
                                color: Color(0xff534F4F),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${postDetail.tenants}",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 20),
                            Text(
                              "Description",
                              style: TextStyle(
                                color: Color(0xff534F4F),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${postDetail.description}",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            isOwnUserToShowContactCard == false
                                ? ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: PostOwnerProfilePage(
                                              userId:
                                                  postDetail.postOwner!.id!),
                                        ),
                                      );
                                    },
                                    tileColor: const Color(0xffE8E8E8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    leading: Hero(
                                      tag: 'ProfileImageTag1',
                                      child: CachedNetworkImage(
                                        imageUrl: postDetail
                                                    .postOwner!.profileUrl !=
                                                null
                                            ? postDetail.postOwner!.profileUrl!
                                            : "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child:
                                              const CircularProgressIndicator(
                                            color: Color(0xffF2AE00),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff534F4F)
                                                .withOpacity(0.5),
                                          ),
                                          width: 100,
                                          height: 100,
                                          child: const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${postDetail.postOwner!.username}",
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${postDetail.postOwner!.mobileNumber}",
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Material(
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${postDetail.price} /m ",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          !isOwnUserToCall
                              ? InkWell(
                                  onTap: () async {
                                    _openPhoneDialer(
                                        "${postDetail.postOwner!.mobileNumber}");
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Call now",
                                            style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: CircleAvatar(
                                            radius: 19,
                                            backgroundColor: Color(0xffF2AE00),
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    final result = await context
                                        .read<PostProvider>()
                                        .deleteMyPost(id);
                                    if (result == true) {
                                      log("FDP : $result");
                                      Navigator.pop(context);
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: CircleAvatar(
                                            radius: 19,
                                            backgroundColor: Color(0xffF2AE00),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
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
        );
      },
    );
  }

  void _openPhoneDialer(String phoneNumber) async {
    Uri url = Uri.parse("tel:$phoneNumber");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      log("launch error");
    }
  }
}
