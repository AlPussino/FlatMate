import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/other_user_post_card.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/notification_pages/toast_notifications.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/view_profile_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostOwnerProfilePage extends StatelessWidget {
  final int userId;
  const PostOwnerProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: FutureBuilder(
          future: context.read<UserProvider>().aboutOtherUser(userId: userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.orangeColor,
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

            final otherUser = context.watch<UserProvider>().otherUser;
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    surfaceTintColor: AppColor.whiteColor,
                    foregroundColor: AppColor.blackColor,
                    automaticallyImplyLeading: true,
                    backgroundColor: AppColor.whiteColor,
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 50,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.all(0),
                      centerTitle: false,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    otherUser!.username!,
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 15,
                                        color: AppColor.greyColor,
                                      ),
                                      Text(
                                        otherUser.mobileNumber!,
                                        style: TextStyle(
                                          color: AppColor.greyColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ...otherUser.socialContacts!
                                            .map(
                                              (e) => Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      _launchUrl(e.profileUrl!);
                                                    },
                                                    child: Icon(
                                                      e.contactType ==
                                                              'FACEBOOK'
                                                          ? Icons.facebook
                                                          : e.contactType ==
                                                                  'TELEGRAM'
                                                              ? Icons.telegram
                                                              : Icons.message,
                                                      size: 30,
                                                      color: AppColor.greyColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ]),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ViewProfileImagePage(
                                        imgUrl: otherUser.profileUrl != null
                                            ? otherUser.profileUrl ?? ""
                                            : "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
                                      ),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl: otherUser.profileUrl != null
                                      ? otherUser.profileUrl!
                                      : "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: AppColor.orangeColor,
                                    backgroundColor: AppColor.whiteColor,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.greyColor
                                                .withOpacity(0.5),
                                          ),
                                          child: const Icon(Icons.error)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: AppColor.dividerColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Posts",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SliverList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: otherUser.postList!.length,
                    itemBuilder: (context, index) {
                      final post = otherUser.postList![index];
                      return OtherUserPostCard(post: post);
                    },
                  )
                ],
              ),
            );
          },
        ));
  }

  Future<void> _launchUrl(String urlStr) async {
    log("tap");
    Uri url0 = Uri.parse(urlStr);
    if (!await launchUrl(
      url0,
      mode: LaunchMode.externalApplication,
    )) {
      ToastNotificatoins.showError('Could not launch $urlStr');
    }
  }
}
