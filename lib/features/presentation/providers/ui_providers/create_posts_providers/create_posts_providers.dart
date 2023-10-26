import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class CreatePostsProvider with ChangeNotifier {
  MultiImagePickerController _selectImagesController =
      MultiImagePickerController(
    maxImages: 9,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
    withData: true,
    withReadStream: true,
    images: [],
  );

  MultiImagePickerController get selectImagesController =>
      _selectImagesController;

  void addImages(ImageFile imageFile) {
    _selectImagesController.addImage(imageFile);
    notifyListeners();
  }
}
