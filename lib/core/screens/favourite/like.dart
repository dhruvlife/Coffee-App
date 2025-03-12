import 'package:figmawc/core/data/product/product_data.dart';
import 'package:figmawc/core/model/product/like_product.dart';
import 'package:figmawc/routes/routes_name.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:figmawc/utils/constants/app_colors.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  final GetStorage storage = GetStorage();
  late List<ProductData> likeProduct;

  @override
  void initState() {
    super.initState();
    likeProduct = ProductData.products
        .where((product) => storage.read(product.name) == true)
        .toList();
  }

  void _showRemoveDialog(ProductData product) {
    Get.defaultDialog(
      title: "Remove Favorite",
      middleText:
          "Are you sure you want to remove this product from favorites?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: AppColors.button,
      buttonColor: AppColors.white,
      onConfirm: () {
        setState(() {
          storage.write(product.name, false);
          likeProduct.remove(product);
          Navigator.pop(context);
        });
      },
  
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                    "My Wishlist",
                    style: TextStyle(
                        fontSize: AppSize.textMedium,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height:35.sp,width:35.sp,
                    decoration: BoxDecoration(
                  color: AppColors.button,
                  borderRadius: BorderRadius.circular(AppSize.buttonRadius),),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.white,
                      size: AppSize.iconMedium,
                    ),
                  )
                ],
              ).paddingSymmetric(horizontal: 10.w),
            ).paddingSymmetric(vertical: 16.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.72,
                ),
                itemCount: likeProduct.length,
                itemBuilder: (context, index) {
                  final product = likeProduct[index];
                  return LikeProduct(
                    image: product.image,
                    productTitle: product.name,
                    productCategories: product.category,
                    productPrice: product.price,
                    rating: product.rating,
                    onProductTap: () {
                      Get.toNamed(RoutesName.productView,arguments: product);
                    },
                    onIconTap: () {
                      _showRemoveDialog(product);
                    },
                    description: product.description,
                    size: product.size,
                    byRate: product.byRate,
                  );
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
