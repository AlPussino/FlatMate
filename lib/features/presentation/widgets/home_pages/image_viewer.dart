import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final List<String> images;

  ImageViewer({super.key, required this.images});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe right (previous image)
            if (pageController.page!.toInt() > 0) {
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          } else if (details.primaryVelocity! < 0) {
            // Swipe left (next image)
            if (pageController.page!.toInt() < images.length - 1) {
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: PageView.builder(
          controller: pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return PhotoView(
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.contained * 4,
              loadingBuilder: (context, event) {
                return const CircularProgressIndicator(
                  color: Color(0xffF2AE00),
                  backgroundColor: Colors.white,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
              // enablePanAlways: true,
              gaplessPlayback: true,
              enableRotation: false,
              backgroundDecoration: const BoxDecoration(
                color: Colors.white,
              ),
              imageProvider: NetworkImage(images[index]),
            );
          },
        ),
      ),
    );
  }
}
