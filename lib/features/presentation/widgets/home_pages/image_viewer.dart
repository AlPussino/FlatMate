import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/picture.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatelessWidget {
  final List<Picture> images;
  final int id;
  ImageViewer({
    super.key,
    required this.images,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: PhotoViewGallery.builder(
        wantKeepAlive: true,
        pageController: PageController(initialPage: id),
        itemCount: images.length,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            onScaleEnd: (context, details, controllerValue) {
              controllerValue.position == Offset(0, 0)
                  ? Navigator.pop(context)
                  : null;
            },
            onTapDown: (context, details, controllerValue) {
              log(controllerValue.toString());
            },
            imageProvider: CachedNetworkImageProvider(images[index].url!),
            initialScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
          );
        },
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: AppColor.orangeColor,
              strokeWidth: 4,
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
      ),
    );
  }
}
