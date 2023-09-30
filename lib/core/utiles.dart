import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/features/data/models/picture.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/home_pages/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';

const Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json'
};

Map<String, String> authHeaders({required String token}) {
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
}

class Utils {
  static headerImagesSlide(bool isMainPost, List<Picture> imageList, String img,
      BuildContext context) {
    List<String> imgStrList = [];
    imageList.map((e) => imgStrList.add(e.url!)).toList();

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
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: img,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Color(0xffF2AE00),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
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
}
