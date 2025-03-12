import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.extraLight,
          borderRadius: BorderRadius.circular(AppSize.buttonRadius),
          boxShadow: [
            BoxShadow(
                color: AppColors.light,
                offset: Offset(0, 2),
                blurRadius: 10,
                spreadRadius: 1),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My Cart",
            style: TextStyle(
                fontSize: AppSize.textMedium, fontWeight: FontWeight.w600),
          ),
          Container(
            height: 35.sp,
            width: 35.sp,
            decoration: BoxDecoration(
              color: AppColors.button,
              borderRadius: BorderRadius.circular(AppSize.buttonRadius),
            ),
            child: Icon(
              Iconsax.shopping_cart,
              color: AppColors.white,
              size: AppSize.iconMedium,
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 10.w),
    );
  }
}
