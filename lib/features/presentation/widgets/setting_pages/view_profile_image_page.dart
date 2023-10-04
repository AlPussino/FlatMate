import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewProfileImagePage extends StatefulWidget {
  final String imgUrl;
  final String imgTag;
  const ViewProfileImagePage({
    super.key,
    required this.imgUrl,
    required this.imgTag,
  });

  @override
  State<ViewProfileImagePage> createState() => _ViewProfileImagePageState();
}

class _ViewProfileImagePageState extends State<ViewProfileImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Hero(
            tag: widget.imgTag,
            child: PhotoView(
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.contained * 4,
              loadingBuilder: (context, event) {
                return const CircularProgressIndicator(
                  color: AppColor.orangeColor,
                  backgroundColor: AppColor.whiteColor,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
              // enablePanAlways: true,
              gaplessPlayback: true,
              enableRotation: false,
              backgroundDecoration: const BoxDecoration(
                color: AppColor.whiteColor,
              ),
              imageProvider: NetworkImage(widget.imgUrl),
            ),
          ),
        ),
      ),
    );
  }
}
