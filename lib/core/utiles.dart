import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
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
  static headerImagesSlide(String img, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            // child: ViewProfileImagePage(
            //   imgUrl: img,
            //   imgTag: "FlatImages",
            // ),
            child: ImageViewer(
              images: [
                'https://images.unsplash.com/photo-1620332372374-f108c53d2e03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=872&q=80',
                'https://images.unsplash.com/photo-1623625434462-e5e42318ae49?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80',
                'https://images.unsplash.com/photo-1520277739336-7bf67edfa768?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1332&q=80',
              ],
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
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

  static showError(String errorMessage) {
    showSimpleNotification(
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.2), // Shadow color
              //     offset: Offset(0, 3), // Offset of the shadow
              //     blurRadius: 5, // Blur radius
              //     spreadRadius: 1, // Spread radius
              //   ),
              // ],
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(7)),
          margin: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Color.fromARGB(255, 252, 49, 49),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        autoDismiss: true,
        contentPadding: const EdgeInsets.all(16),
        background: Colors.transparent,
        elevation: 0,
        position: NotificationPosition.bottom);
  }

  static showSuccess(String errorMessage) {
    showSimpleNotification(
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.2), // Shadow color
              //     offset: Offset(0, 3), // Offset of the shadow
              //     blurRadius: 5, // Blur radius
              //     spreadRadius: 1, // Spread radius
              //   ),
              // ],
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(7)),
          margin: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 136, 62),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        autoDismiss: true,
        contentPadding: const EdgeInsets.all(16),
        background: Colors.transparent,
        elevation: 0,
        position: NotificationPosition.bottom);
  }
}
