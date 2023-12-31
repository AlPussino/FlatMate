import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:finding_apartments_yangon/features/data/models/apartment.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/create_posts_providers/create_posts_providers.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/create_post_pages/create_post_widgets/flat_floor_drop_down_button.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/create_post_pages/create_post_widgets/flat_type_drop_down_button.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/create_post_pages/flat_location_create_post.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/utils/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FlatCreatePost extends StatefulWidget {
  final post;
  final isEdit;
  const FlatCreatePost({super.key, this.post, required this.isEdit});

  @override
  State<FlatCreatePost> createState() => _FlatCreatePostState();
}

class _FlatCreatePostState extends State<FlatCreatePost> {
  final _formKey = GlobalKey<FormState>();

  bool _showError = false;

  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();

  final FocusNode _lengthFocusNode = FocusNode();
  final FocusNode _widthFocusNode = FocusNode();

  bool lengthError = false;
  bool widthError = false;

  List<String> imagesStringUrls = [];
  List<File> files = [];
  List<int> removeImagesIdList = [];

  Future<List<File>> downloadImages(List<String> imageUrls) async {
    final tempDir = await getTemporaryDirectory();

    for (String imageUrl in imageUrls) {
      try {
        final response = await http.get(Uri.parse(imageUrl));

        final file = File(
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await file.writeAsBytes(response.bodyBytes);
        files.add(file);
      } catch (e) {
        print('Error downloading image: $e');
      }
    }

    int index = 0;
    while (index < files.length) {
      final file = files[index];
      context.read<CreatePostsProvider>().addImages(ImageFile(
            file.uri.toString(),
            name: file.path,
            extension: file.path.split('.').last,
            path: file.path,
          ));
      index++;
    }

    log("before build Images : ${context.read<CreatePostsProvider>().selectImagesController.images.length}");

    return files;
  }

  void changeImg(List<String> imageUrls) async {
    await downloadImages(imageUrls);
  }

  @override
  void initState() {
    super.initState();
    loadMyanmarData();
    if (widget.isEdit) {
      context.read<CreatePostsProvider>().selectImagesController.clearImages();

      int index = 0;
      while (index < widget.post.pictures.length) {
        final url = widget.post.pictures[index].url;
        final id = widget.post.pictures[index].id;
        imagesStringUrls.add(url);
        removeImagesIdList.add(id);
        index++;
      }

      changeImg(imagesStringUrls);
      _lengthController.text = '${widget.post.apartment.length}';
      _widthController.text = '${widget.post.apartment.width}';
    } else {
      context.read<CreatePostsProvider>().selectImagesController.clearImages();
    }
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _lengthFocusNode.dispose();
    _widthFocusNode.dispose();
    super.dispose();
  }

  Future<void> loadMyanmarData() async {
    await context.read<PostProvider>().loadMyanmarData();
  }

  @override
  Widget build(BuildContext context) {
    log("Images : ${context.read<CreatePostsProvider>().selectImagesController.images.length}");
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.transparent,
        foregroundColor: AppColor.blackColor,
        automaticallyImplyLeading: true,
        title: Text(
          !widget.isEdit ? "New Post" : "Edit Post",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (selectedFloorValue.isNotEmpty &&
                    selectedHouseTypeValue.isNotEmpty &&
                    _lengthController.text.isNotEmpty &&
                    _widthController.text.isNotEmpty &&
                    context
                            .read<CreatePostsProvider>()
                            .selectImagesController
                            .images
                            .length >
                        0) {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: FlatLocationCreatePost(
                          images: context
                              .read<CreatePostsProvider>()
                              .selectImagesController
                              .images,
                          flatBody: Post(
                            removeImagesId:
                                widget.isEdit ? removeImagesIdList : null,
                            apartment: Apartment(
                              floor: int.parse(selectedFloorValue),
                              length: double.parse(_lengthController.text),
                              width: double.parse(_widthController.text),
                              apartmentType: selectedHouseTypeValue,
                            ),
                          ),
                          post: widget.isEdit ? widget.post : null,
                        )),
                  );
                } else if (selectedFloorValue.isNotEmpty &&
                    selectedHouseTypeValue.isNotEmpty &&
                    _lengthController.text.isNotEmpty &&
                    _widthController.text.isNotEmpty &&
                    context
                            .watch<CreatePostsProvider>()
                            .selectImagesController
                            .images
                            .length <
                        1) {
                  toast('Please select at least 1 image');
                }
              }
            },
            child: Text(
              "Next",
              style: TextStyle(
                  color: selectedFloorValue.isNotEmpty &&
                          selectedHouseTypeValue.isNotEmpty &&
                          _lengthController.text.isNotEmpty &&
                          _widthController.text.isNotEmpty &&
                          context
                                  .watch<CreatePostsProvider>()
                                  .selectImagesController
                                  .images
                                  .length >
                              0
                      ? AppColor.orangeColor
                      : AppColor.greyColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            MultiImagePickerView(
              draggable: true,
              addButtonTitle: '+ add photos',
              initialContainerBuilder: (context, pickerCallback) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      pickerCallback.call();
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.dividerColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.isEdit
                              ? CircularProgressIndicator(
                                  color: AppColor.orangeColor,
                                  backgroundColor: AppColor.whiteColor,
                                )
                              : Icon(
                                  Icons.image,
                                  color: AppColor.greyColor,
                                ),
                          const SizedBox(height: 5),
                          Text(
                            widget.isEdit
                                ? AppString.loadingImageToEditPost
                                : AppString.addImageToPost,
                            style: TextStyle(
                              color: AppColor.greyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              addMoreButtonTitle: '+',
              controller:
                  context.watch<CreatePostsProvider>().selectImagesController,
              onChange: (list) {
                if (context
                        .watch<CreatePostsProvider>()
                        .selectImagesController
                        .images
                        .length >
                    5) {
                  toast("if not necessary,please don't use above 5 images");
                }
                ;
              },
              padding: const EdgeInsets.all(20),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flat type",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rental house type",
                            style: TextStyle(
                              color: AppColor.greyColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FlatTypeDropDownButton(
                              post: widget.isEdit ? widget.post : null),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Floor",
                            style: TextStyle(
                              color: AppColor.greyColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FlatFloorDropDownButton(
                              post: widget.isEdit ? widget.post : null),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Area (square feet)",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Length",
                            style: TextStyle(
                              color: AppColor.greyColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 80,
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            child: TextFormField(
                              cursorColor: AppColor.orangeColor,
                              style: TextStyle(
                                  color: AppColor.textColor, fontSize: 14),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              controller: _lengthController,
                              obscureText: false,
                              focusNode: _lengthFocusNode,
                              decoration: Utils.textFormFieldDecoration(15),
                              onChanged: (value) {
                                setState(() {
                                  lengthError = !isLengthValid(value);
                                });
                                if (_showError) {
                                  setState(() {});
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter length';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _lengthController.text = value!;
                                _lengthFocusNode.unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Width",
                            style: TextStyle(
                              color: AppColor.greyColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 80,
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            child: TextFormField(
                              style: TextStyle(
                                  color: AppColor.textColor, fontSize: 14),
                              textInputAction: TextInputAction.done,
                              controller: _widthController,
                              obscureText: false,
                              focusNode: _widthFocusNode,
                              cursorColor: AppColor.orangeColor,
                              keyboardType: TextInputType.number,
                              decoration: Utils.textFormFieldDecoration(50),
                              onChanged: (value) {
                                setState(() {
                                  widthError = !isWidthValid(value);
                                });
                                if (_showError) {
                                  setState(() {
                                    _showError = false;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter width';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _widthController.text = value!;
                                _widthFocusNode.unfocus();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isLengthValid(String length) {
    return length.isNotEmpty;
  }

  bool isWidthValid(String width) {
    return width.isNotEmpty;
  }
}
