import 'package:finding_apartments_yangon/features/data/models/apartment.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/profile_pages/create_post_pages/flat_location_create_post.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';

class FlatCreatePost extends StatefulWidget {
  const FlatCreatePost({super.key});

  @override
  State<FlatCreatePost> createState() => _FlatCreatePostState();
}

class _FlatCreatePostState extends State<FlatCreatePost> {
  final _formKey = GlobalKey<FormState>();

  final _selectImagesController = MultiImagePickerController(
    maxImages: 9,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
    withData: true,
    withReadStream: true,
    images: <ImageFile>[],
  );

  String selectedHouseTypeValue = 'CONDO';
  List<String> houseTypeOptions = [
    'CONDO',
    'MINI_CONDO',
    'FLAT',
    'HOSTEL',
    'HOUSE',
    'WHOLE_HOUSE'
  ];

  String selectedFloorValue = '0';
  List<String> floorOptions =
      List.generate(20, (index) => (index + 0).toString());

  bool _showError = false;

  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();

  final FocusNode _lengthFocusNode = FocusNode();
  final FocusNode _widthFocusNode = FocusNode();

  bool lengthError = false;
  bool widthError = false;

  @override
  void dispose() {
    _selectImagesController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _lengthFocusNode.dispose();
    _widthFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          "New Post",
          style: TextStyle(
            color: Color(0xff000000),
            // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
            fontSize: 20,
          ),
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
                    _selectImagesController.images.length > 0) {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: FlatLocationCreatePost(
                          images: _selectImagesController.images,
                          flatBody: Post(
                            apartment: Apartment(
                              floor: int.parse(selectedFloorValue),
                              length: double.parse(_lengthController.text),
                              width: double.parse(_widthController.text),
                              apartmentType: selectedHouseTypeValue,
                            ),
                          ),
                        )),
                  );
                } else if (selectedFloorValue.isNotEmpty &&
                    selectedHouseTypeValue.isNotEmpty &&
                    _lengthController.text.isNotEmpty &&
                    _widthController.text.isNotEmpty &&
                    _selectImagesController.images.length < 1) {
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
                          _selectImagesController.images.length > 0
                      ? Color(0xffF2AE00)
                      : Colors.grey,
                  // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
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
              addButtonTitle: '+',
              addMoreButtonTitle: '+',
              controller: _selectImagesController,
              onChange: (list) {
                setState(() {
                  if (_selectImagesController.images.length > 5) {
                    toast("if not necessary,please don't use above 5 images");
                  }
                });
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
                      color: Color(0xff534F4F),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
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
                              color: Color(0xff534F4F),
                              //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                              ),
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(),
                                alignment: Alignment.centerLeft,
                                borderRadius: BorderRadius.circular(10),
                                style: TextStyle(
                                  color: Color(0xff534F4F),
                                  // fontFamily: DefaultTextStyle.of(context)
                                  //     .style
                                  //     .fontFamily,
                                  fontSize: 14,
                                ),
                                value: selectedHouseTypeValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedHouseTypeValue = newValue!;
                                  });
                                },
                                items: houseTypeOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Floor",
                            style: TextStyle(
                              color: Color(0xff534F4F),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                              ),
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: DropdownButton<String>(
                                underline: Container(),
                                isExpanded: true,
                                alignment: Alignment.centerLeft,
                                borderRadius: BorderRadius.circular(10),
                                style: TextStyle(
                                  color: Color(0xff534F4F),
                                  // fontFamily: DefaultTextStyle.of(context)
                                  //     .style
                                  //     .fontFamily,
                                  fontSize: 14,
                                ),
                                value: selectedFloorValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedFloorValue = newValue!;
                                  });
                                },
                                items: floorOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value == '0'
                                        ? "Ground floor"
                                        : "${value}th floor"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Area (square feet)",
                    style: TextStyle(
                      color: Color(0xff534F4F),
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
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
                              color: Color(0xff534F4F),
                              //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 80,
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            child: TextFormField(
                              cursorColor: Color(0xffF2AE00),
                              style: TextStyle(
                                  color: Color(0xff2E2E2E),
                                  fontFamily: DefaultTextStyle.of(context)
                                      .style
                                      .fontFamily,
                                  fontSize: 14),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              controller: _lengthController,
                              obscureText: false,
                              focusNode: _lengthFocusNode,
                              decoration: textFormFieldDecoration(15),
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
                              color: Color(0xff534F4F),
                              //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 80,
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            child: TextFormField(
                              style: TextStyle(
                                  color: Color(0xff2E2E2E),
                                  // fontFamily: DefaultTextStyle.of(context)
                                  //     .style
                                  //     .fontFamily,
                                  fontSize: 14),
                              textInputAction: TextInputAction.done,
                              controller: _widthController,
                              obscureText: false,
                              focusNode: _widthFocusNode,
                              cursorColor: Color(0xffF2AE00),
                              keyboardType: TextInputType.number,
                              decoration: textFormFieldDecoration(50),
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

  InputDecoration textFormFieldDecoration(int hintText) {
    return InputDecoration(
      suffixText: 'feet',
      hintStyle: TextStyle(color: Colors.grey),
      hintText: hintText.toString(),
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Color(0xff534F4F),
        ),
      ),
    );
  }
}
