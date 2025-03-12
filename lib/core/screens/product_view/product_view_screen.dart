import 'package:figmawc/core/data/product/product_data.dart';
import 'package:figmawc/routes/routes_name.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:figmawc/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class ProductViewScreen extends StatefulWidget {
  final ProductData product;
  const ProductViewScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  String selectedSize = AppStrings.sizeS;
  double displayedPrice = 0.0;
  bool isExpanded = false;
  late bool isLove;
  bool? isSuffixShow;
  final GetStorage storage = GetStorage();

  @override
  void initState() {
    super.initState();
    isLove = storage.read(widget.product.name) ?? false;
    updatePrice();
  }

  void updatePrice() {
    switch (selectedSize) {
      case AppStrings.sizeM:
        displayedPrice = widget.product.price * 1.5;
        break;
      case AppStrings.sizeL:
        displayedPrice = widget.product.price * 1.75;
        break;
      default:
        displayedPrice = widget.product.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AppStrings.svgArrowLeft,
            height: 30.h,
            width: 30.w,
          ),
        ),

        // Title Text
        title: Text(
          AppStrings.productViewTitle,
          style: TextStyle(
            fontSize: AppSize.textMediumLarge,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isLove = !isLove;
                storage.write(widget.product.name, isLove);
              });
            },
            icon: SvgPicture.asset(
              AppStrings.svgHeart,
              height: 30.h,
              width: 30.w,
              colorFilter: ColorFilter.mode(
                isLove ? AppColors.bottomNav : AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.buttonRadius),
              child: Image.asset(
                widget.product.image,
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ).paddingOnly(bottom: 16.h, top: 10.h),
            Column(
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                      fontSize: AppSize.textLarge, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.category,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: AppSize.textMedium,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.light.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.circular(AppSize.buttonRadius)),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delivery_dining,
                              color: AppColors.button,
                              size: AppSize.iconLarge,
                            )),
                      ).paddingOnly(right: 4.w),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.light.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.circular(AppSize.buttonRadius)),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.door_sliding,
                              color: AppColors.button,
                              size: AppSize.iconLarge,
                            )),
                      ).paddingOnly(right: 4.w),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.light.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.circular(AppSize.buttonRadius)),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Iconsax.milk,
                              color: AppColors.button,
                              size: AppSize.iconMedium,
                            )),
                      ).paddingOnly(right: 4.w)
                    ],
                  )
                ],
              ),
            ).paddingOnly(bottom: 4.h),
            Row(
              children: [
                Icon(
                  Iconsax.star1,
                  color: AppColors.yellow,
                  size: AppSize.iconExtraLarge,
                ).paddingOnly(right: 4.w),
                Text(
                  // product Rating,
                  widget.product.rating.toString(),
                  style: TextStyle(
                      fontSize: AppSize.textMediumLarge,
                      fontWeight: FontWeight.w500),
                ).paddingOnly(right: 4.w),
                Text(
                  // product Rating,
                  "(${widget.product.byRate.toString()})",
                  style: TextStyle(
                      color: AppColors.grey,
                      fontSize: AppSize.textSmallMedium,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ).paddingOnly(bottom: 6.h),
            Divider(
              height: 1.h,
              color: AppColors.light,
              indent: 20.w,
              endIndent: 20.w,
            ).paddingOnly(bottom: 4.h),

            SizedBox(
              height: 120.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // product Description,
                      AppStrings.description,
                      style: TextStyle(
                          fontSize: AppSize.textLarge,
                          fontWeight: FontWeight.w600),
                    ).paddingOnly(bottom: 2.h),
                    Text(
                      isExpanded
                          ? widget.product.description
                          : widget.product.description.length > 100
                              ? "${widget.product.description.substring(0, 100)}..."
                              : widget.product.description,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: AppSize.textSmallMedium,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? AppStrings.readLess : AppStrings.readMore,
                        style: TextStyle(
                          color: AppColors.button,
                          fontSize: AppSize.textSmallMedium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 10.h),
              ),
            ),

            Text(
              AppStrings.size,
              style: TextStyle(
                  fontSize: AppSize.textLarge, fontWeight: FontWeight.w500),
            ).paddingOnly(bottom: 10.h),
            SizedBox(
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSizeButton(AppStrings.sizeS),
                  buildSizeButton(AppStrings.sizeM),
                  buildSizeButton(AppStrings.sizeL),
                ],
              ),
            ).paddingOnly(bottom: 20.h),
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSize.buttonRadius)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.price,
                        style: TextStyle(
                          fontSize: AppSize.textMedium,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        strutStyle: StrutStyle(),
                        "\$ ${displayedPrice.toString().length > 5 ? displayedPrice.toString().substring(0, 5) : displayedPrice.toString()}",
                        style: TextStyle(
                            color: AppColors.button,
                            overflow: TextOverflow.ellipsis,
                            fontSize: AppSize.textMediumLarge,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ).paddingOnly(left: 10.w),
                  SizedBox(
                    height: 50.h,
                    width: 0.5.sw,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSize.buttonRadius))),
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.button)),
                      onPressed: () {
                        Get.toNamed(
                          RoutesName.order,
                          arguments: widget.product,
                        );
                      },
                      child: Text(
                        AppStrings.pvsButton,
                        style: TextStyle(
                            fontSize: AppSize.textMedium,
                            color: AppColors.white),
                      ),
                    ),
                  ).paddingOnly(right: 10.w),
                ],
              ),
            ).paddingOnly(bottom: 20.h),
          ],
        ).paddingSymmetric(
          horizontal: 24.w,
        ),
      ),
    );
  }

  Widget buildSizeButton(String size) {
    final isSelected = size == selectedSize;

    return SizedBox(
      width: 0.25.sw,
      height: 40.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor:
              isSelected ? AppColors.button.withOpacity(0.2) : AppColors.white,
          side: BorderSide(color: AppColors.light),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.buttonRadius),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedSize = size;
            updatePrice();
          });
        },
        child: Text(
          size,
          style: TextStyle(
            fontSize: AppSize.textLarge,
            fontWeight: FontWeight.w300,
            color: isSelected ? AppColors.button : AppColors.black,
          ),
        ),
      ),
    );
  }
}
