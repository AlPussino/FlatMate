import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldDecoration {
  static textFormFieldDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: AppColor.whiteColor,
      contentPadding: EdgeInsets.all(20),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColor.greyColor,
      ),
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
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
    );
  }
}
