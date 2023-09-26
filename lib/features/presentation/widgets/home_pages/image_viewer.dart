import 'package:finding_apartments_yangon/features/data/models/picture.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  final List<Picture> images;
  final int id;

  ImageViewer({
    super.key,
    required this.images,
    required this.id,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  // final PageController pageController = PageController(initialPage: 0);

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
        controller: PageController(initialPage: widget.id),
        itemCount: widget.images.length,
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
                    color: Color(0xffF2AE00),
                    backgroundColor: Colors.white,
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
                color: Colors.white,
              ),
              imageProvider: NetworkImage(widget.images[index].url!),
            ),
          );
        },
      ),
    );
  }
}
