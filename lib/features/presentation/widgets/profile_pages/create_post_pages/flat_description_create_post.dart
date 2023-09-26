import 'package:finding_apartments_yangon/features/data/models/apartment.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';

class FlatDescriptionCreatePost extends StatefulWidget {
  final Post flatBody;
  final Iterable<ImageFile> images;
  const FlatDescriptionCreatePost(
      {super.key, required this.flatBody, required this.images});

  @override
  State<FlatDescriptionCreatePost> createState() =>
      _FlatDescriptionCreatePostState();
}

class _FlatDescriptionCreatePostState extends State<FlatDescriptionCreatePost> {
  final _contractController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pricePerMonthController = TextEditingController();
  final _totalPeopleController = TextEditingController();

  final FocusNode _contractFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _pricePerMonthFocusNode = FocusNode();
  final FocusNode _totalPeopleFocusNode = FocusNode();

  bool contractError = false;
  bool descriptionError = false;
  bool pricePerMonthError = false;
  bool totalPeopleError = false;

  final _formKey = GlobalKey<FormState>();

  bool _showError = false;
  bool isPosting = false;
  bool isButtonDisabled = false;

  @override
  void dispose() {
    _contractController.dispose();
    _descriptionController.dispose();
    _pricePerMonthController.dispose();
    _totalPeopleController.dispose();

    _contractFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _pricePerMonthFocusNode.dispose();
    _totalPeopleFocusNode.dispose();

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
          "Flat Descriptions",
          style: TextStyle(
            color: Color(0xff000000),
            //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              isButtonDisabled ? null : handleButtonClick();
            },
            child: isPosting
                ? const CircularProgressIndicator(color: Color(0xffF2AE00))
                : Text(
                    "Post",
                    style: TextStyle(
                        color: _contractController.text.isNotEmpty &&
                                _descriptionController.text.isNotEmpty &&
                                _pricePerMonthController.text.isNotEmpty &&
                                _totalPeopleController.text.isNotEmpty
                            ? Color(0xffF2AE00)
                            : Colors.grey,
                        // fontFamily:
                        //     DefaultTextStyle.of(context).style.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Text(
                "Flat description",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Contract",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Color(0xffF2AE00),
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff2E2E2E),
                    //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                    fontSize: 14),
                textInputAction: TextInputAction.done,
                controller: _contractController,
                obscureText: false,
                focusNode: _contractFocusNode,
                decoration:
                    textFormFieldDecoration('3months | 6months | 1year | Nego'),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter contract';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contractController.text = value!;
                  _contractFocusNode.unfocus();
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Description",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Color(0xffF2AE00),
                maxLines: 5,
                style: TextStyle(
                    color: Color(0xff2E2E2E),
                    //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                    fontSize: 14),
                textInputAction: TextInputAction.newline,
                controller: _descriptionController,
                obscureText: false,
                focusNode: _descriptionFocusNode,
                decoration: textFormFieldDecoration('Fuck you bro'),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descriptionController.text = value!;
                  _descriptionFocusNode.unfocus();
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Price per month",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Color(0xffF2AE00),
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff2E2E2E),
                    //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                    fontSize: 14),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: _pricePerMonthController,
                obscureText: false,
                focusNode: _pricePerMonthFocusNode,
                decoration: textFormFieldDecoration('300000'),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price per month';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pricePerMonthController.text = value!;
                  _pricePerMonthFocusNode.unfocus();
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Total tenants",
                style: TextStyle(
                  color: Color(0xff534F4F),
                  //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Color(0xffF2AE00),

                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff2E2E2E),
                    //    // fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                    fontSize: 14),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: _totalPeopleController,
                obscureText: false,
                focusNode: _totalPeopleFocusNode,
                decoration: textFormFieldDecoration('6'),
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
                    return 'Please enter expected tenants';
                  }
                  return null;
                },
                onSaved: (value) {
                  _totalPeopleController.text = value!;
                  _totalPeopleFocusNode.unfocus();
                },
              ),
            ],
          ),
        ),
      ),
    );
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

  InputDecoration textFormFieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
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
    );
  }

  void handleButtonClick() async {
    if (!isButtonDisabled) {
      setState(() {
        isButtonDisabled = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          isPosting = true;
        });
        if (_contractController.text.isNotEmpty &&
            _descriptionController.text.isNotEmpty &&
            _pricePerMonthController.text.isNotEmpty &&
            _totalPeopleController.text.isNotEmpty) {
          final result =
              await context.read<PostProvider>().uploadImagesAndCreatePost(
                  widget.images,
                  Post(
                    contract: _contractController.text,
                    description: _descriptionController.text,
                    price: double.parse(_pricePerMonthController.text),
                    tenants: int.parse(_totalPeopleController.text),
                    apartment: Apartment(
                      apartmentType: widget.flatBody.apartment!.apartmentType,
                      floor: widget.flatBody.apartment!.floor,
                      length: widget.flatBody.apartment!.length,
                      width: widget.flatBody.apartment!.width,
                    ),
                    state: widget.flatBody.state,
                    township: widget.flatBody.township,
                    additional: widget.flatBody.additional,
                  ));

          if (result != null) {
            setState(() {
              isPosting = false;
              isButtonDisabled = false;
            });
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {
            print('asdf');
            setState(() {
              isPosting = false;
              isButtonDisabled = false;
            });
          }
        } else {
          null;
        }
        setState(() {
          isPosting = false;
          isButtonDisabled = false;
        });
      } else {
        setState(() {
          isButtonDisabled = false;
          _showError = true;
        });
      }
    }
  }
}
