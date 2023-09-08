import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final List<String> images;

  ImageViewer({super.key, required this.images});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
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
                    color: Color(0xffF2AE00),
                    backgroundColor: Colors.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
              enablePanAlways: false,
              gaplessPlayback: true,
              enableRotation: false,
              backgroundDecoration: const BoxDecoration(
                color: Colors.white,
              ),
              imageProvider: NetworkImage(images[index]),
            ),
          );
        },
      ),
    );
  }
}
