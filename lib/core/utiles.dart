import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../features/presentation/widgets/setting/view_profile_image_page.dart';

class Utils {
  static headerImagesSlide(String img, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ViewProfileImagePage(
              imgUrl: img,
              imgTag: "FlatImages",
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Hero(
          tag: "FlatImages",
          child: CachedNetworkImage(
            imageUrl: img,
            placeholder: (context, url) => const Center(
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
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  static tap() {
    log("Tap Tap");
  }
}
