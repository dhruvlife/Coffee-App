import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSize {
  // text size
  static final textSmall = 10.sp;
  static final textSmallMedium = 12.sp;
  static final textMedium = 14.sp;
  static final textMediumLarge = 16.sp;
  static final textLarge = 18.sp;

  // title and subtitle
  static final titleLarge = 32.sp;
  static final titleSmall = 20.sp;
  static final subtitleMedium = 14.sp;

  // icon size
  static final iconSmall = 12.w;
  static final iconMedium = 16.w;
  static final iconLarge = 18.w;
  static final iconExtraLarge = 26.w;

  // bottom nav menu curv radius
  static final bottomNavCurvRadius = 24.r;

  // button text
  static final buttonTextLarge = 10.sp;
  static final buttonTextSmall = 18.sp;
  static final buttonTextMedium = 14.sp;

  // searchbar
  static final searchBarPadding = 24.sp;
  static final searchBarRadius = 10.r;

  // button radius
  static final buttonRadius = 16.r;

  // bottom nav radius
  static final bottomNavBarRadius = 24.r;

  // return context height and width
  static Size getHW() {
    return Size(Get.width, Get.height);
  }
}
