import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/edit_profile_widgets/profile_upload_bottom_sheet.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/view_profile_image_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EditProfileCard extends StatelessWidget {
  final myUser;
  const EditProfileCard({super.key, required this.myUser});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: ViewProfileImagePage(
                  imgUrl: myUser.profileUrl != null
                      ? myUser.profileUrl ?? ""
                      : "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
                ),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CachedNetworkImage(
                imageUrl: myUser.profileUrl != null
                    ? myUser.profileUrl ?? ""
                    : "https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148483453.jpg?w=740&t=st=1694579352~exp=1694579952~hmac=fb3ade8ee793f7b89b94ff12fa773da23e827fb82279da7c36ffd3eb3033d98f",
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
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppColor.orangeColor,
                    backgroundColor: AppColor.whiteColor,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.greyColor.withOpacity(0.5),
                    ),
                    child: Icon(Icons.error)),
              ),
              Positioned(
                right: -10,
                bottom: -8,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        uploadProfile(context, myUser);
                      },
                      icon: Icon(
                        Icons.add_circle_sharp,
                        size: 20,
                        color: AppColor.orangeColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
