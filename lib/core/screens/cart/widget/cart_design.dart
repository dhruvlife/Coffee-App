import 'package:figmawc/core/screens/cart/cart_data.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  final CartData cartData;
  final Function(CartData) onRemove;
  const Cart({
    super.key,
    required this.cartData,
    required this.onRemove,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void increaseQuantity(BuildContext context) {
    setState(() {
      widget.cartData.quantity++;
    });
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Deletion',
            style: TextStyle(
                fontSize: AppSize.textLarge, fontWeight: FontWeight.w500),
          ),
          content: Text(
            'Are you sure you want to remove this item from the cart?',
            style: TextStyle(fontSize: AppSize.textMedium),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: () {
                widget.onRemove(
                    widget.cartData); 
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                    color: AppColors.button, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        );
      },
    );
  }

  void decreaseQuantity(BuildContext context) {
    if (widget.cartData.quantity > 1) {
      setState(() {
      widget.cartData.quantity--;
      });
    }else{
      showDeleteDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.extraLight,
        border: Border.all(color: AppColors.white, width: 2.sp),
        borderRadius: BorderRadius.circular(AppSize.buttonRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.buttonRadius),
                child: Image.asset(
                  widget.cartData.image,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.fill,
                ),
              ).paddingOnly(right: 12.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartData.name,
                    style: TextStyle(
                        fontSize: AppSize.textMedium,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                  Row(
                    children: [
                      Text(
                        "Qty :",
                        style: TextStyle(
                            fontSize: AppSize.textSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey),
                      ).paddingOnly(right: 10.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            decreaseQuantity(context);
                          });
                        },
                        child: quantityButton("-").paddingOnly(right: 10.w),
                      ),
                      Text(
                        widget.cartData.quantity.toString(),
                        style: TextStyle(
                          fontSize: AppSize.textMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ).paddingOnly(right: 10.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            increaseQuantity(context);
                          });
                        },
                        child: quantityButton("+").paddingOnly(right: 10.w),
                      ),
                    
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Price : ",
                        style: TextStyle(
                            fontSize: AppSize.textMedium,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey),
                      ).paddingOnly(right: 10.w),
                      Text(
                        widget.cartData.price.toString(),
                        style: TextStyle(
                          fontSize: AppSize.textMedium,
                          fontWeight: FontWeight.w600,
                          color: AppColors.button,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Container(
            height: 50.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(1, 1),
                    color: AppColors.grey,
                    blurRadius: 1,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.circular(AppSize.buttonRadius),
            ),
            child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: IconButton(
                onPressed: () {
                  showDeleteDialog();
                },
                icon: Icon(
                  Icons.delete,
                  size: AppSize.iconLarge,
                  color: AppColors.button,
                ),
              ),
            ),
          ).paddingOnly(
            right: 10.w,
          ),
        ],
      ),
    );
  }

  Widget quantityButton(
    String symbol,
  ) {
    return Container(
      height: 20.sp,
      width: 20.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.buttonRadius),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: AppSize.textMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
