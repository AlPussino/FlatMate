import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoadingShimmer extends StatelessWidget {
  const SearchLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 0.1,
        child: Shimmer.fromColors(
          baseColor: AppColor.greyColor,
          highlightColor: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 20.0,
                            color: AppColor.whiteColor, // Shimmer effect
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: 150.0,
                            height: 12.0,
                            color: AppColor.whiteColor, // Shimmer effect
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
