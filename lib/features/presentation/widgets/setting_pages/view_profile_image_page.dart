import 'dart:developer';

import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewProfileImagePage extends StatefulWidget {
  final String imgUrl;
  const ViewProfileImagePage({
    super.key,
    required this.imgUrl,
  });

  @override
  State<ViewProfileImagePage> createState() => _ViewProfileImagePageState();
}

class _ViewProfileImagePageState extends State<ViewProfileImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: Center(
        child: Center(
          child: PhotoView(
            onTapDown: (context, details, controllerValue) {
              log(controllerValue.position.toString());
            },
            onScaleEnd: (context, details, controllerValue) {
              controllerValue.position == Offset(0.0, 0.0)
                  ? Navigator.pop(context)
                  : null;
            },
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
            loadingBuilder: (context, event) {
              return const CircularProgressIndicator(
                color: AppColor.orangeColor,
                backgroundColor: AppColor.whiteColor,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
            enablePanAlways: false,
            gaplessPlayback: true,
            enableRotation: false,
            backgroundDecoration: const BoxDecoration(
              color: AppColor.blackColor,
            ),
            imageProvider: NetworkImage(widget.imgUrl),
          ),
        ),
      ),
    );
  }
}
