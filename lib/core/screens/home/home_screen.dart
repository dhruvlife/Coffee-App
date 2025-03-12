import 'package:figmawc/core/data/product/product_data.dart';
import 'package:figmawc/core/model/product/product.dart';
import 'package:figmawc/core/screens/cart/cart_data.dart';
import 'package:figmawc/core/screens/home/home_header.dart';
import 'package:figmawc/routes/routes_name.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  List<CartData> cartItems = [];

  @override
  Widget build(BuildContext context) {
    final categories = ['All'] +
        ProductData.products
            .map((product) => product.category)
            .toSet()
            .toList();
    final filteredProducts = selectedCategory == 'All'
        ? ProductData.products
        : ProductData.products
            .where((product) => product.category == selectedCategory)
            .toList();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),

            Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSize.buttonRadius),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories
                      .map(
                        (category) => SizedBox(
                          width: 120.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedCategory == category
                                  ? AppColors.button
                                  : AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Text(
                             category.length>=9 ? "${category.toString().substring(0,9)}...":category,
                              style: TextStyle(
                                color: selectedCategory == category
                                    ? AppColors.white
                                    : AppColors.button,
                                fontSize: AppSize.textMedium,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).marginOnly(right: 8.w),
                      )
                      .toList(),
                ),
              ),
            ).paddingSymmetric(horizontal: 10.w),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width <= 800
                        ? 2
                        : MediaQuery.of(context).size.width <= 1200
                            ? 3
                            : 4,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.72),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final cartData = CartData(
                    image: product.image,
                    name: product.name,
                    category: product.category,
                    description: product.description,
                    rating: product.rating,
                    price: product.price,
                    size: product.size,
                    byRate: product.byRate,
                  );

                  return Product(
                    size: product.size,
                    description: product.description,
                    image: product.image,
                    productTitle: product.name,
                    productCategories: product.category,
                    productPrice: product.price,
                    rating: product.rating,
                    byRate: product.byRate,
                    onProductTap: () {
                      Get.toNamed(RoutesName.productView, arguments: product);
                    },
                    onIconTap: () {
                      CartManager.addToCart(cartData);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),
                            content: Text(
                          "${product.name} added to cart Successfully.",
                          style: TextStyle(fontSize: AppSize.buttonTextMedium),
                        )));

                    },
                  );
                },
              ).paddingSymmetric(horizontal: 24.w, vertical: 16.h),
            ),
          ],
        ),
      ),
    );
  }
}
