import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: AppColor.whiteColor,
      elevation: 0,
      shadowColor: AppColor.whiteColor,
      title: Text(
        'Are you sure you want to exit?',
        style: TextStyle(
          color: AppColor.greyColor,
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "NO",
            style: TextStyle(
              color: AppColor.orangeColor,
              fontSize: 14,
            ),
          ),
          onPressed: () => Navigator.of(context).maybePop(false),
        ),
        TextButton(
          child: Text(
            "YES",
            style: TextStyle(
              color: AppColor.orangeColor,
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }
}
