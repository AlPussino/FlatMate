import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Notis {
  static showError(String errorMessage) {
    showSimpleNotification(
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(7)),
          margin: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Color.fromARGB(255, 252, 49, 49),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        autoDismiss: true,
        contentPadding: const EdgeInsets.all(16),
        background: Colors.transparent,
        elevation: 0,
        position: NotificationPosition.bottom);
  }

  static showSuccess(String successMessage) {
    showSimpleNotification(
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(7)),
          margin: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                successMessage,
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 136, 62),
                  fontFamily: 'Dosis',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        autoDismiss: true,
        contentPadding: const EdgeInsets.all(16),
        background: Colors.transparent,
        elevation: 0,
        position: NotificationPosition.bottom);
  }
}
