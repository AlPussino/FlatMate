import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:overlay_support/overlay_support.dart';

class MultipleSelectImages extends StatefulWidget {
  final selectImagesController;
  const MultipleSelectImages({super.key, required this.selectImagesController});

  @override
  State<MultipleSelectImages> createState() => _MultipleSelectImagesState();
}

class _MultipleSelectImagesState extends State<MultipleSelectImages> {
  @override
  Widget build(BuildContext context) {
    return MultiImagePickerView(
      draggable: true,
      addButtonTitle: '+',
      addMoreButtonTitle: '+',
      controller: widget.selectImagesController,
      onChange: (list) {
        setState(() {
          if (widget.selectImagesController.images.length > 5) {
            toast("if not necessary,please don't use above 5 images");
          }
        });
      },
      padding: const EdgeInsets.all(20),
    );
  }
}
