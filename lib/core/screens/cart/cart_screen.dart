import 'package:figmawc/core/screens/cart/cart_data.dart';
import 'package:figmawc/core/screens/cart/widget/cart_appbar.dart';
import 'package:figmawc/core/screens/cart/widget/cart_design.dart';
import 'package:figmawc/core/screens/cart/widget/cart_divider.dart';
import 'package:figmawc/core/screens/cart/widget/cart_price_section.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartData> cartData = CartManager.cartData;
  late double totalPrice;

  void removeItemFromCart(CartData cartItem) {
    setState(() {
      cartData.remove(cartItem);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item Removed Successfully")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CartAppBar().paddingSymmetric(vertical: 16.h),
            SizedBox(height: 20.h),
            Expanded(
              child: cartData.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartData.length,
                      itemBuilder: (context, index) {
                        return Cart(
                          cartData: CartManager.cartData[index],
                          onRemove: removeItemFromCart,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No items in cart",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
            ),
            CartDivider().paddingOnly(bottom: 10.h),
            CartPriceSection(
              totalPrice: CartManager.getTotalPrice(),
            ),
            CartDivider().paddingOnly(bottom: 10.h),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.buttonRadius),
                  ),
                  backgroundColor: AppColors.button,
                ),
                onPressed: () {},
                child: Text(
                  "Place Order",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 24.w, vertical: 10.h),
      ),
    );
  }
}
