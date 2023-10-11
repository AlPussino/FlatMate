import 'package:customizable_counter/customizable_counter.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:flutter/material.dart';

class BottomSheetToEditTenants {
  static void bottomSheetToEditTenants(BuildContext context, Post post) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("This flat have left "),
                  CustomizableCounter(
                    borderColor: Colors.yellow,
                    showButtonText: false,
                    borderWidth: 2,
                    borderRadius: 5,
                    backgroundColor: AppColor.whiteColor,
                    textColor: AppColor.orangeColor,
                    textSize: 18,
                    count: post.tenants!.toDouble(),
                    step: 1,
                    minCount: 0,
                    maxCount: post.tenants!.toDouble(),
                    incrementIcon: const Icon(
                      Icons.add,
                      color: AppColor.orangeColor,
                    ),
                    decrementIcon: const Icon(
                      Icons.remove,
                      color: AppColor.orangeColor,
                    ),
                    onCountChange: (count) {},
                  ),
                  Text("tenants"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: Size(500, 50),
                        backgroundColor: AppColor.orangeColor,
                      ),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
