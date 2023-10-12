import 'package:customizable_counter/customizable_counter.dart';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/profile_providers/edit_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class BottomSheetToEditTenants {
  static void bottomSheetToEditTenants(BuildContext context, Post post) {
    showModalBottomSheet(
        enableDrag: true,
        backgroundColor: AppColor.whiteColor,
        useSafeArea: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        context: context,
        builder: (BuildContext context) {
          final leftTenants = context.watch<EditPostProvider>().leftTenants;
          return Container(
            height: 250,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("This flat have left "),
                  CustomizableCounter(
                    borderColor: AppColor.orangeColor,
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
                    onCountChange: (count) {
                      count == 0
                          ? toast("This flat is full of tenants now")
                          : null;
                      context
                          .read<EditPostProvider>()
                          .editTenants(count.toInt());
                      ;
                    },
                  ),
                  Text("tenants"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        print(post.id.toString());
                        print(context.read<EditPostProvider>().leftTenants!);
                        final result = await context
                            .read<PostProvider>()
                            .editTenants(post.id!, leftTenants!);

                        if (result != null) Navigator.pop(context);
                        context
                            .read<EditPostProvider>()
                            .restartEditPostProvider();
                      },
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
