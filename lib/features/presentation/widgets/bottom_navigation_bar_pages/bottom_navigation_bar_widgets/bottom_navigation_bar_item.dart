import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarItems {
  static bottomNavigationBarItem(
      int currentIndex,
      int BottomNavigationBarItemIndex,
      String svgPath,
      String labelAndTooltip) {
    return BottomNavigationBarItem(
      icon: ColorFiltered(
        colorFilter: ColorFilter.mode(
          currentIndex == BottomNavigationBarItemIndex
              ? AppColor.orangeColor
              : AppColor.bottomNavigationBarIconColor,
          BlendMode.srcIn,
        ),
        child: SvgPicture.asset(
          svgPath,
        ),
      ),
      label: labelAndTooltip,
      tooltip: labelAndTooltip,
    );
  }
}
