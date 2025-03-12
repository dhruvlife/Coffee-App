// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:figmawc/core/screens/cart/cart_data.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';

class CartPriceSection extends StatefulWidget {
  double totalPrice;
  CartPriceSection({
    super.key,
    required this.totalPrice,
  });

  @override
  State<CartPriceSection> createState() => _CartPriceSectionState();
}

class _CartPriceSectionState extends State<CartPriceSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price :",
                style: TextStyle(
                    fontSize: AppSize.textMedium, fontWeight: FontWeight.w600),
              ),
              Text(
                "\$ ${widget.totalPrice.toString()}",
                style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: AppSize.textMedium,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total save :",
                style: TextStyle(
                    fontSize: AppSize.textMedium, fontWeight: FontWeight.w600),
              ),
              Text(
                "- \$ 0.00",
                style: TextStyle(
                    fontSize: AppSize.textMedium,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ).paddingOnly(bottom: 10.h),
          Divider(
            height: 2,
            color: AppColors.extraLight,
          ).paddingOnly(bottom: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Pay :",
                style: TextStyle(
                    fontSize: AppSize.textMedium,
                    color: AppColors.button,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "\$${CartManager.getTotalPrice()}",
                style: TextStyle(
                    color: AppColors.darkgreen,
                    fontSize: AppSize.textMedium,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ).paddingOnly(bottom: 10.h),
        ],
      ),
    );
  }
}
