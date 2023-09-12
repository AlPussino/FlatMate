import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _selectImagesController = MultiImagePickerController(
    maxImages: 15,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
    withData: true,
    withReadStream: true,
    images: <ImageFile>[], // array of pre/default selected images
  );
  String selectedCityValue = 'Yangon';
  List<String> cityOptions = ['Yangon', 'Mandalay'];

  String selectedTownshipValue = 'Hlaing';
  List<String> townshipOptions = [
    'Hlaing',
    'Kamayut',
    'Dagon',
    'Bahan',
    'Sule'
  ];

  String selectedHouseTypeValue = 'Condo';
  List<String> houseTypeOptions = [
    'Condo',
    'Mini condo',
    'flat',
    'Hostel',
    'Whole house'
  ];

  String selectedFloorValue = '1';
  List<String> floorOptions = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  final _additionAddressController = TextEditingController();
  final _contractController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pricePerMonthController = TextEditingController();
  final _totalPeopleController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();

  final FocusNode _additionalAddressFocusNode = FocusNode();
  final FocusNode _contractFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _pricePerMonthFocusNode = FocusNode();
  final FocusNode _totalPeopleFocusNode = FocusNode();
  final FocusNode _lengthFocusNode = FocusNode();
  final FocusNode _widthFocusNode = FocusNode();

  bool additionalAddressError = false;
  bool contractError = false;
  bool descriptionError = false;
  bool pricePerMonthError = false;
  bool totalPeopleError = false;
  bool lengthError = false;
  bool widthError = false;

  final _formKey = GlobalKey<FormState>();

  bool _showError = false;
  bool isPosting = false;

  @override
  void dispose() {
    _selectImagesController.dispose();

    _additionAddressController.dispose();
    _contractController.dispose();
    _descriptionController.dispose();
    _pricePerMonthController.dispose();
    _totalPeopleController.dispose();
    _lengthController.dispose();
    _widthController.dispose();

    _additionalAddressFocusNode.dispose();
    _contractFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _pricePerMonthFocusNode.dispose();
    _totalPeopleFocusNode.dispose();
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
        title: const Text(
          "Add Post",
          style: TextStyle(
            color: Color(0xff000000),
            fontFamily: 'Dosis',
            fontSize: 20,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MultiImagePickerView(
                  addMoreButtonTitle: 'add more',
                  controller: _selectImagesController,
                  onChange: (list) {
                    log(list.toString());
                  },
                  padding: const EdgeInsets.all(10),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Location",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "City",
                                style: TextStyle(
                                  color: Color(0xff534F4F),
                                  fontFamily: 'Dosis',
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                width:
                                    (MediaQuery.sizeOf(context).width / 2) - 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    alignment: Alignment.centerLeft,
                                    borderRadius: BorderRadius.circular(10),
                                    style: TextStyle(
                                      color: Color(0xff534F4F),
                                      fontFamily: 'Dosis',
                                      fontSize: 14,
                                    ),
                                    value: selectedCityValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCityValue = newValue!;
                                      });
                                    },
                                    items: cityOptions
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
                              const Text(
                                "Township",
                                style: TextStyle(
                                  color: Color(0xff534F4F),
                                  fontFamily: 'Dosis',
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                width:
                                    (MediaQuery.sizeOf(context).width / 2) - 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    alignment: Alignment.centerLeft,
                                    borderRadius: BorderRadius.circular(10),
                                    style: TextStyle(
                                      color: Color(0xff534F4F),
                                      fontFamily: 'Dosis',
                                      fontSize: 14,
                                    ),
                                    value: selectedTownshipValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedTownshipValue = newValue!;
                                      });
                                    },
                                    items: townshipOptions
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Additional location",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        maxLines: 2,
                        style: const TextStyle(
                            color: Color(0xff2E2E2E),
                            fontFamily: 'Dosis',
                            fontSize: 14),
                        textInputAction: TextInputAction.done,
                        controller: _additionAddressController,
                        obscureText: false,
                        focusNode: _additionalAddressFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            additionalAddressError =
                                !isAdditionalAddressValid(value);
                            isPosting = false;
                          });
                          if (_showError) {
                            setState(() {
                              _showError = false;
                            });
                          }
                        },
                        // onSubmitted: (s) {
                        //   _focusNode.unfocus();
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _additionAddressController.text = value!;
                          _additionalAddressFocusNode.unfocus();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Flat type",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rental house type",
                                style: TextStyle(
                                  color: Color(0xff534F4F),
                                  fontFamily: 'Dosis',
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                width:
                                    (MediaQuery.sizeOf(context).width / 2) - 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    alignment: Alignment.centerLeft,
                                    borderRadius: BorderRadius.circular(10),
                                    style: TextStyle(
                                      color: Color(0xff534F4F),
                                      fontFamily: 'Dosis',
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
                              const Text(
                                "Floor",
                                style: TextStyle(
                                  color: Color(0xff534F4F),
                                  fontFamily: 'Dosis',
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                width:
                                    (MediaQuery.sizeOf(context).width / 2) - 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    alignment: Alignment.centerLeft,
                                    borderRadius: BorderRadius.circular(10),
                                    style: TextStyle(
                                      color: Color(0xff534F4F),
                                      fontFamily: 'Dosis',
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
                                        child: Text(value),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Color(0xff2E2E2E),
                                  fontFamily: 'Dosis',
                                  fontSize: 14),
                              textInputAction: TextInputAction.done,
                              controller: _lengthController,
                              obscureText: false,
                              focusNode: _lengthFocusNode,
                              decoration: InputDecoration(
                                hintText: 'length (feet)',
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  lengthError = !isLengthValid(value);
                                  isPosting = false;
                                });
                                if (_showError) {
                                  setState(() {
                                    _showError = false;
                                  });
                                }
                              },
                              // onSubmitted: (s) {
                              //   _focusNode.unfocus();
                              // },
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
                          Container(
                            height: 50,
                            width: (MediaQuery.sizeOf(context).width / 2) - 30,
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Color(0xff2E2E2E),
                                  fontFamily: 'Dosis',
                                  fontSize: 14),
                              textInputAction: TextInputAction.done,
                              controller: _widthController,
                              obscureText: false,
                              focusNode: _widthFocusNode,
                              decoration: InputDecoration(
                                hintText: "width (feet)",
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xff534F4F),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  widthError = !isWidthValid(value);
                                  isPosting = false;
                                });
                                if (_showError) {
                                  setState(() {
                                    _showError = false;
                                  });
                                }
                              },
                              // onSubmitted: (s) {
                              //   _focusNode.unfocus();
                              // },
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
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Contract",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        maxLines: 2,
                        style: const TextStyle(
                            color: Color(0xff2E2E2E),
                            fontFamily: 'Dosis',
                            fontSize: 14),
                        textInputAction: TextInputAction.done,
                        controller: _contractController,
                        obscureText: false,
                        focusNode: _contractFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            contractError = !isContractValid(value);
                            isPosting = false;
                          });
                          if (_showError) {
                            setState(() {
                              _showError = false;
                            });
                          }
                        },
                        // onSubmitted: (s) {
                        //   _focusNode.unfocus();
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _contractController.text = value!;
                          _contractFocusNode.unfocus();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        maxLines: 5,
                        style: const TextStyle(
                            color: Color(0xff2E2E2E),
                            fontFamily: 'Dosis',
                            fontSize: 14),
                        textInputAction: TextInputAction.newline,
                        controller: _descriptionController,
                        obscureText: false,
                        focusNode: _descriptionFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            descriptionError = !isDescriptionValid(value);
                            isPosting = false;
                          });
                          if (_showError) {
                            setState(() {
                              _showError = false;
                            });
                          }
                        },
                        // onSubmitted: (s) {
                        //   _focusNode.unfocus();
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _descriptionController.text = value!;
                          _descriptionFocusNode.unfocus();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Price per month",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        maxLines: 1,
                        style: const TextStyle(
                            color: Color(0xff2E2E2E),
                            fontFamily: 'Dosis',
                            fontSize: 14),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        controller: _pricePerMonthController,
                        obscureText: false,
                        focusNode: _pricePerMonthFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            pricePerMonthError = !isPricePerMonthValid(value);
                            isPosting = false;
                          });
                          if (_showError) {
                            setState(() {
                              _showError = false;
                            });
                          }
                        },
                        // onSubmitted: (s) {
                        //   _focusNode.unfocus();
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _pricePerMonthController.text = value!;
                          _pricePerMonthFocusNode.unfocus();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Total people",
                        style: TextStyle(
                          color: Color(0xff534F4F),
                          fontFamily: 'Dosis',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        maxLines: 2,
                        style: const TextStyle(
                            color: Color(0xff2E2E2E),
                            fontFamily: 'Dosis',
                            fontSize: 14),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        controller: _totalPeopleController,
                        obscureText: false,
                        focusNode: _totalPeopleFocusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff534F4F),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            totalPeopleError = !isTotalPeopleValid(value);
                            isPosting = false;
                          });
                          if (_showError) {
                            setState(() {
                              _showError = false;
                            });
                          }
                        },
                        // onSubmitted: (s) {
                        //   _focusNode.unfocus();
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _totalPeopleController.text = value!;
                          _totalPeopleFocusNode.unfocus();
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(500, 50),
                          backgroundColor: const Color(0xffF2AE00),
                        ),
                        child: const Text(
                          "Post",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Dosis',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isAdditionalAddressValid(String additionalAddress) {
    return additionalAddress.isNotEmpty;
  }

  bool isContractValid(String contract) {
    return contract.isNotEmpty;
  }

  bool isDescriptionValid(String description) {
    return description.isNotEmpty;
  }

  bool isPricePerMonthValid(String pricePerMonth) {
    return pricePerMonth.isNotEmpty;
  }

  bool isTotalPeopleValid(String totalPeople) {
    return totalPeople.isNotEmpty;
  }

  bool isLengthValid(String length) {
    return length.isNotEmpty;
  }

  bool isWidthValid(String width) {
    return width.isNotEmpty;
  }
}
