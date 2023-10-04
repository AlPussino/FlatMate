import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/picture.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
    // widget.images.map((e) => print(e.id.toString())).toList();
    return Scaffold(
      //   body: PageView(
      //     controller: PageController(initialPage: widget.id),
      //     onPageChanged: (index) {},
      //     children: widget.images.map((imageUrl) {
      //       return Image.network(imageUrl.url!);
      //     }).toList(),
      //   ),

      body: PageView.builder(
        controller: PageController(initialPage: id),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Center(
            child: PhotoView(
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.contained * 4,
              loadingBuilder: (context, event) {
                return SizedBox(
                  height: 50,
                  width: 50,
                  child: const CircularProgressIndicator(
                    color: AppColor.orangeColor,
                    backgroundColor: AppColor.whiteColor,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
              enablePanAlways: true,
              gaplessPlayback: false,
              enableRotation: false,
              backgroundDecoration: const BoxDecoration(
                color: AppColor.whiteColor,
              ),
              imageProvider: NetworkImage(images[index].url!),
            ),
          );
        },
      ),
    );
  }
}
