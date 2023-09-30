import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/data/models/my_user.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyProfileCard extends StatefulWidget {
  final MyUser myUser;
  const MyProfileCard({super.key, required this.myUser});

  @override
  State<MyProfileCard> createState() => _MyProfileCardState();
}

class _MyProfileCardState extends State<MyProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 200,
        width: MediaQuery.sizeOf(context).width,
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
                  child: EditProfilePage()),
            );
          },
          child: Card(
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 53,
                      backgroundColor: Color(0xffF2AE00),
                      child: CachedNetworkImage(
                        imageUrl: widget.myUser.profileUrl ??
                            "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
                        imageBuilder: (context, imageProvider) => Container(
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
                        progressIndicatorBuilder: (context, url, progress) {
                          return const CircularProgressIndicator(
                            color: Color(0xffF2AE00),
                            backgroundColor: Colors.white,
                          );
                        },
                        errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff534F4F),
                            ),
                            child: const Icon(Icons.error)),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.myUser.username ?? "",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily:
                                  DefaultTextStyle.of(context).style.fontFamily,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.myUser.mobileNumber ?? "",
                            style: TextStyle(
                              color: Color(0xff534F4F),
                              fontFamily:
                                  DefaultTextStyle.of(context).style.fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.myUser.email ?? "",
                            style: TextStyle(
                              color: Color(0xff534F4F),
                              fontFamily:
                                  DefaultTextStyle.of(context).style.fontFamily,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
