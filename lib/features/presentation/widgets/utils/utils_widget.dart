import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/picture.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Utils {
  static headerImagesSlide(bool isMainPost, List<Picture> imageList, String img,
      BuildContext context) {
    List<String> imgStrList = [];
    int index = 0;
    while (index < imageList.length) {
      imgStrList.add(imageList[index].url!);
      index++;
    }
    List<Map<int, String>> myList = [];

    for (int i = 0; i < imgStrList.length; i++) {
      myList.add({i: imgStrList[i]});
    }

    return AbsorbPointer(
      absorbing: isMainPost ? true : false,
      child: InkWell(
        onTap: () {
          int? foundId;
          for (final entry in myList) {
            if (entry.values.first == img) {
              print(entry.values.first);
              foundId = entry.keys.first;
              break;
            }
          }
          if (foundId != -1) {
            print('Found ID: $foundId');
          } else {
            print('String not found in the list.');
          }
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: ImageViewer(
                id: foundId!,
                images: imageList,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: img,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              double? progress = downloadProgress.progress;
              return Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: AppColor.orangeColor,
                    value: progress,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  static textFormFieldDecoration(int hintText) {
    return InputDecoration(
      suffixText: 'feet',
      hintStyle: TextStyle(color: AppColor.bottomNavigationBarIconColor),
      hintText: hintText.toString(),
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
    );
  }
}
