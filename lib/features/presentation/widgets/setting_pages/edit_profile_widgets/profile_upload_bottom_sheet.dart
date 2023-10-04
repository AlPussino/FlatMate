import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/my_user.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void uploadProfile(BuildContext context, MyUser myUser) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    isDismissible: true,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(
                      color: AppColor.orangeColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await context
                          .read<UserProvider>()
                          .pickImageAndSaveToSever(myUser.profileUrl, true);
                    },
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      size: 30,
                      color: AppColor.orangeColor,
                    ),
                  ),
                ),
                Text(
                  'Camera',
                  style: TextStyle(fontSize: 20, color: AppColor.orangeColor),
                )
              ],
            ),

            //

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(
                      color: AppColor.orangeColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      Navigator.pop(context);

                      await context
                          .read<UserProvider>()
                          .pickImageAndSaveToSever(myUser.profileUrl, false);
                    },
                    icon: Icon(
                      Icons.image_rounded,
                      size: 30,
                      color: AppColor.orangeColor,
                    ),
                  ),
                ),
                Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20, color: AppColor.orangeColor),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
