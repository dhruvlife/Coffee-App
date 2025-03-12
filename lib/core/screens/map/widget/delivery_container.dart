import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:figmawc/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeliveryContainer extends StatelessWidget {
  const DeliveryContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.grey, width: 1.sp),
          borderRadius: BorderRadius.circular(AppSize.buttonRadius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                color: AppColors.extraLight,
                border: Border.all(color: AppColors.grey, width: 1.sp),
                borderRadius: BorderRadius.circular(AppSize.buttonRadius)),
            child: Icon(
              Icons.delivery_dining,
              color: AppColors.button,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "On Going Your Order . . .",
                style: TextStyle(
                    fontSize: AppSize.textMediumLarge,
                    fontWeight: FontWeight.w600),
              ).paddingSymmetric(vertical: 8.h),
              Text(
                "Will Deliver At : ",
                style: TextStyle(
                    fontSize: AppSize.textMedium, fontWeight: FontWeight.w300),
              ).paddingSymmetric(vertical: 4.h),
              Expanded(
                child: Text(
                  "${AppStrings.address.substring(0, 40)}...",
                  style: TextStyle(
                      fontSize: AppSize.textSmall, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
