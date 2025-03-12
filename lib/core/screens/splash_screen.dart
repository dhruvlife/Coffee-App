import 'package:figmawc/routes/routes_name.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_image_strings.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:figmawc/utils/constants/app_strings.dart';
import 'package:figmawc/common/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            AppImageStrings.onboarding, 
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.fill,
          ),
          // Bottom content with text and button
          Container(
            alignment: Alignment.bottomCenter,
            height: 300.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.9),
                  blurRadius: 30.r,
                  spreadRadius: 30.r,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title Text
                Text(
                  AppStrings.onboardingTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSize.titleLarge,
                  ),
                ),
                SizedBox(height: 8.h),
                // Subtitle Text
                Text(
                  AppStrings.onboardingSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSize.textMedium,
                  ),
                ),
                SizedBox(height: 20.h),
                // Button
                SizedBox(
                  height: 0.06.sh,
                  width: 0.8.sh,
                  child: ElevatedButtonWidget(
                    onPressed: () {
                      Get.toNamed(RoutesName.bottomMenu);
                    },
                    text: AppStrings.onboardingButtonText,
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 32.w, vertical: 32.h),
        ],
      ),
    );
  }
}
