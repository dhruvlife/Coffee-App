import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Product extends StatelessWidget {
  final String image;
  final String productTitle;
  final String productCategories;
  final String description;
  final double productPrice;
  final double rating;
  final int byRate;
  final String size;
  final VoidCallback onProductTap;
  final VoidCallback onIconTap;

  const Product({
    required this.image,
    required this.productTitle,
    required this.productCategories,
    required this.productPrice,
    required this.rating,
    required this.onProductTap,
    super.key,
    required this.onIconTap,
    required this.description,
    required this.size,
    required this.byRate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProductTap,
      child: Container(
        height: 240.h,
        width: 128.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.buttonRadius),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 126.h,
                  ),
                ).paddingSymmetric(horizontal: 4.w).marginOnly(top: 2.h),
                Positioned(
                  top: 6,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        '$rating',
                        style: TextStyle(
                            fontSize: AppSize.textMedium,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    productTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.textMedium,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    productCategories,
                    style: TextStyle(
                      fontSize: AppSize.textMedium,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ $productPrice',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.textMedium,
                          color: AppColors.black,
                        ),
                      ),
                      Container(
                        height: 28.h,
                        width: 28.h,
                        decoration: BoxDecoration(
                            color: AppColors.button,
                            borderRadius: BorderRadius.circular(6.r)),
                        child: IconButton(
                            onPressed: onIconTap,
                            icon: Center(
                              child: Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: AppSize.iconSmall,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ).paddingSymmetric(horizontal: 6.w, vertical: 1.h),
            ),
          ],
        ),
      ),
    );
  }
}
