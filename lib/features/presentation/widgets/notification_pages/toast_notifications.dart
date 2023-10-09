import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class ToastNotificatoins {
  static showError(String errorMessage) {
    showSimpleNotification(
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(7)),
          margin: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: AppColor.redColor,
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        autoDismiss: true,
        contentPadding: const EdgeInsets.all(16),
        background: AppColor.transparent,
        elevation: 0,
        position: NotificationPosition.bottom);
  }

  static showSuccess(String successMessage) {
    showSimpleNotification(
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(7)),
          margin: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                successMessage,
                style: TextStyle(
                  color: AppColor.greenColor,
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        autoDismiss: true,
        contentPadding: const EdgeInsets.all(16),
        background: AppColor.transparent,
        elevation: 0,
        position: NotificationPosition.bottom);
  }
}
