import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/utils_widget.dart';

class InputTextFormField extends StatefulWidget {
  final controller;
  final focusNode;
  final unit;
  const InputTextFormField(
      {super.key, required this.controller, this.focusNode, this.unit});

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

bool lengthError = false;
bool _showError = false;

class _InputTextFormFieldState extends State<InputTextFormField> {
  @override
  void dispose() {
    widget.controller.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: (MediaQuery.sizeOf(context).width / 2) - 30,
      child: TextFormField(
        cursorColor: AppColor.orangeColor,
        style: TextStyle(color: AppColor.textColor, fontSize: 14),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        controller: widget.controller,
        obscureText: false,
        focusNode: widget.focusNode,
        decoration: Utils.textFormFieldDecoration(15),
        onChanged: (value) {
          setState(() {
            lengthError = !isInputValid(value);
          });
          if (_showError) {
            setState(() {});
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter ${widget.unit}';
          }
          return null;
        },
        onSaved: (value) {
          widget.controller.text = value!;
          widget.focusNode.unfocus();
        },
      ),
    );
  }

  bool isInputValid(String input) {
    return input.isNotEmpty;
  }
}
