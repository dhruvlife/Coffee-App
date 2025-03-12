import 'package:figmawc/common/searchbar.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_image_strings.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:figmawc/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 240.h,
          width: 1.sw,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.homeContainerS,
                AppColors.homeContainerF,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.homeTitle,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: AppSize.textSmallMedium,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    AppStrings.homeSubTitle,
                    style: TextStyle(
                      color: AppColors.light,
                      fontSize: AppSize.textMediumLarge,
                    ),
                  ).paddingOnly(right: 4.w),
                  SvgPicture.asset(
                    AppStrings.svgArrowDown,
                    height: 20.h,
                    width: 20.w,
                    colorFilter:
                        ColorFilter.mode(AppColors.light, BlendMode.srcIn),
                  )
                ],
              ),
            ).paddingOnly(bottom: 20.h),
            SearchBarWidget(
              suffixIconData: AppStrings.svgFilter,
              onSuffixAction: () {},
              leadingIconData: Icons.search,
              searchTitle: AppStrings.onboardingButtonText,
            ).paddingOnly(bottom: 20.h),
            Container(
              height: 140.h,
              width: 0.9.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.searchBarRadius),
              ),
              child: Image.asset(
                AppImageStrings.banner,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 24.w, vertical: 12.h),
      ],
    );
  }
}
