import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/apartment.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/create_post_pages/flat_description_create_post.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FlatLocationCreatePost extends StatefulWidget {
  final Post flatBody;
  final Iterable<ImageFile> images;
  const FlatLocationCreatePost(
      {super.key, required this.flatBody, required this.images});

  @override
  State<FlatLocationCreatePost> createState() => _FlatLocationCreatePostState();
}

class _FlatLocationCreatePostState extends State<FlatLocationCreatePost> {
  final _formKey = GlobalKey<FormState>();

  final _additionAddressController = TextEditingController();

  FocusNode stateFocusNode = FocusNode();
  FocusNode townshipFocusNode = FocusNode();
  FocusNode _additionalAddressFocusNode = FocusNode();

  bool additionalAddressError = false;
  bool _showError = false;

  String selectedRegion = "စစ်ကိုင်းတိုင်းဒေသကြီး";
  String? selectedTownship;
  List<MyanmarData> myanmarData = [];

  @override
  Widget build(BuildContext context) {
    myanmarData = context.read<PostProvider>().myanmarData;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.whiteColor,
        foregroundColor: AppColor.blackColor,
        automaticallyImplyLeading: true,
        title: Text(
          "Flat Location",
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

                if (selectedRegion.isNotEmpty &&
                    selectedTownship != null &&
                    _additionAddressController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: FlatDescriptionCreatePost(
                          images: widget.images,
                          flatBody: Post(
                            apartment: Apartment(
                              apartmentType:
                                  widget.flatBody.apartment!.apartmentType,
                              floor: widget.flatBody.apartment!.floor,
                              length: widget.flatBody.apartment!.length,
                              width: widget.flatBody.apartment!.width,
                            ),
                            state: selectedRegion,
                            township: selectedTownship,
                            additional: _additionAddressController.text,
                          ),
                        )),
                  );
                } else if (selectedRegion.isNotEmpty &&
                    selectedTownship == null &&
                    _additionAddressController.text.isNotEmpty) {
                  toast("please select township");
                } else {
                  null;
                }
              }
            },
            child: Text(
              "Next",
              style: TextStyle(
                  color: selectedRegion.isNotEmpty &&
                          selectedTownship != null &&
                          _additionAddressController.text.isNotEmpty
                      ? AppColor.orangeColor
                      : AppColor.greyColor,
                  // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Text(
                "Flat location",
                style: TextStyle(
                  color: AppColor.greyColor,
                  // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "State / Division",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.greyColor, // Border color
                      ),
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton(
                        focusNode: stateFocusNode,
                        isExpanded: true,
                        underline: SizedBox(),
                        alignment: Alignment.centerLeft,
                        borderRadius: BorderRadius.circular(10),
                        style: TextStyle(
                          color: AppColor.greyColor,
                          // fontFamily:
                          //     DefaultTextStyle.of(context).style.fontFamily,
                          fontSize: 12,
                        ),
                        value: selectedRegion,
                        onTap: () {
                          stateFocusNode.unfocus();
                        },
                        onChanged: (newValue) {
                          setState(() {
                            selectedRegion = newValue!;
                            selectedTownship = null;
                          });
                        },
                        items: myanmarData.map((value) {
                          return DropdownMenuItem(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Township",
                    style: TextStyle(
                      color: AppColor.greyColor,
                      // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.greyColor, // Border color
                      ),
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton<String>(
                        focusNode: townshipFocusNode,
                        isExpanded: true,
                        underline: SizedBox(),
                        alignment: Alignment.centerLeft,
                        borderRadius: BorderRadius.circular(10),
                        style: TextStyle(
                          color: AppColor.greyColor,
                          // fontFamily:
                          //     DefaultTextStyle.of(context).style.fontFamily,
                          fontSize: 12,
                        ),
                        value: selectedTownship,
                        onTap: () {
                          townshipFocusNode.unfocus();
                          log('tap');
                          log(townshipFocusNode.hasFocus.toString());
                        },
                        onChanged: (newValue) {
                          setState(() {
                            townshipFocusNode.unfocus();
                            selectedTownship = newValue!;
                            log(townshipFocusNode.hasFocus.toString());
                          });
                        },
                        items: myanmarData
                            .firstWhere((data) => data.name == selectedRegion)
                            .townships
                            .map((township) {
                          return DropdownMenuItem(
                            value: township.name,
                            child: Text(township.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "App. Suite, Unit Building ",
                style: TextStyle(
                  color: AppColor.greyColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: AppColor.orangeColor,
                maxLines: 5,
                style: TextStyle(color: AppColor.textColor, fontSize: 14),
                textInputAction: TextInputAction.newline,
                controller: _additionAddressController,
                obscureText: false,
                focusNode: _additionalAddressFocusNode,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColor.greyColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColor.greyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColor.greyColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColor.greyColor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    additionalAddressError = !isAdditionalAddressValid(value);
                  });
                  if (_showError) {
                    setState(() {
                      _showError = false;
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter App,Unit...';
                  }
                  return null;
                },
                onSaved: (value) {
                  _additionAddressController.text = value!;
                  _additionalAddressFocusNode.unfocus();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isAdditionalAddressValid(String additionalAddress) {
    return additionalAddress.isNotEmpty;
  }
}
