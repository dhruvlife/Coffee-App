import 'package:figmawc/core/data/product/product_data.dart';
import 'package:figmawc/core/screens/cart/cart_data.dart';
import 'package:figmawc/routes/routes_name.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:figmawc/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OrderScreen extends StatefulWidget {
  final ProductData product;
  const OrderScreen({
    super.key,
    required this.product,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isSelectedCategoryDeliver = true;
  int quantity = 1;
  final controller = Get.put(OrderController());
  late double totalPrice;
  late double totalPriceWDF;

  @override
  void initState() {
    totalPrice = widget.product.price;
    totalPriceWDF = widget.product.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AppStrings.svgArrowLeft,
            height: 30.h,
            width: 30.w,
          ),
        ).paddingOnly(left: 10.w),
        title: Text(
          AppStrings.orderTitle,
          style: TextStyle(
            fontSize: AppSize.textLarge,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.extraLight,
                        borderRadius:
                            BorderRadius.circular(AppSize.buttonRadius)),
                    width: 0.8.sw,
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 0.35.sw,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelectedCategoryDeliver
                                  ? AppColors.button
                                  : AppColors.extraLight,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isSelectedCategoryDeliver = true;
                              });
                            },
                            child: Text(
                              AppStrings.delivery,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isSelectedCategoryDeliver
                                    ? AppColors.white
                                    : AppColors.black,
                                fontSize: AppSize.textMedium,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.35.sw,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelectedCategoryDeliver
                                  ? AppColors.extraLight
                                  : AppColors.button,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isSelectedCategoryDeliver = false;
                              });
                            },
                            child: Text(
                              AppStrings.pickUp,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isSelectedCategoryDeliver
                                    ? AppColors.black
                                    : AppColors.white,
                                fontSize: AppSize.textMedium,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(
                    right: 20.w,
                    left: 20.w,
                    top: 20.h,
                  ),
                ),
              ],
            ).paddingOnly(bottom: 24.h),
            Expanded(
              child: isSelectedCategoryDeliver
                  ? buildDeliveryView()
                  : buildPickupView(),
            ),
            Container(
              height: 160.h,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSize.buttonRadius)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    trailing: SvgPicture.asset(
                      AppStrings.svgArrowDown,
                      height: 20.sp,
                      width: 20.sp,
                    ),
                    leading: Icon(
                      Iconsax.wallet,
                      size: AppSize.iconLarge,
                      color: AppColors.button,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cash/Wallet",
                          style: TextStyle(
                              fontSize: AppSize.textMedium,
                              fontWeight: FontWeight.w700),
                        ),
                        Obx(
                          () {
                            return Text(
                              "\$ ${controller.totalPrice(quantity, widget.product.price).toStringAsPrecision(5)}",
                              style: TextStyle(
                                  color: AppColors.button,
                                  fontSize: AppSize.textMedium,
                                  fontWeight: FontWeight.w500),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSize.buttonRadius),
                        ),
                      ),
                      onPressed: () {
                        final cartDataItem = CartManager.cartData.firstWhere(
                          (cartData) => cartData.name == widget.product.name,
                          orElse: () => CartData(
                            image: widget.product.image,
                            name: widget.product.name,
                            category: widget.product.category,
                            description: widget.product.description,
                            rating: widget.product.rating,
                            price: widget.product.price,
                            size: widget.product.size,
                            byRate: widget.product.byRate,
                          ),
                        );
                        CartManager.addToCart(cartDataItem);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),
                            content: Text(
                          "${widget.product.name} added to cart Successfully.",
                          style: TextStyle(fontSize: AppSize.buttonTextMedium),
                        )));

                        Get.toNamed(
                          RoutesName.cart,
                        );
                      },
                      child: Text(
                        AppStrings
                            .orderTitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppSize.textMedium,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 10.w),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 24.w),
      ),
    );
  }

  Widget buildDeliveryView() {
    return Stack(alignment: Alignment.bottomCenter, children: [
      ListView(
        children: [
          Text(
            AppStrings.deliveryAddress,
            style: TextStyle(
                fontSize: AppSize.textMediumLarge, fontWeight: FontWeight.w600),
          ).paddingOnly(bottom: 16.h),
          Obx(
            () {
              return Text(
                controller.address.value,
                style: TextStyle(
                    fontSize: AppSize.buttonTextMedium,
                    fontWeight: FontWeight.w500),
              ).paddingOnly(bottom: 4.h);
            },
          ),
          Obx(() {
            return Text(
              controller.note.value,
              style: TextStyle(
                  fontSize: AppSize.textSmallMedium,
                  fontWeight: FontWeight.w300),
            );
          }).paddingOnly(bottom: 16.h),
          SizedBox(
            height: 35.h,
            child: Row(
              children: [
                SizedBox(
                  height: 35.h,
                  width: 130.w,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.editAddress();
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: AppColors.grey, width: 1),
                      backgroundColor: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.edit,
                          color: AppColors.black,
                          size: AppSize.iconSmall,
                        ).paddingOnly(right: 8.w),
                        Text(
                          AppStrings.addressCollectButton,
                          style: TextStyle(
                              fontSize: AppSize.textSmall,
                              color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ).paddingOnly(right: 10.w),
                SizedBox(
                  height: 35.h,
                  width: 130.w,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNote();
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: AppColors.grey, width: 1),
                      backgroundColor: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.note_1,
                          color: AppColors.black,
                          size: AppSize.iconSmall,
                        ).paddingOnly(right: 8.w),
                        Text(
                          AppStrings.noteButton,
                          style: TextStyle(
                              fontSize: AppSize.textSmall,
                              color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).paddingOnly(bottom: 16.h),
          Divider(
            height: 1.h,
            color: AppColors.extraLight,
            indent: 20.w,
            endIndent: 20.w,
          ).paddingOnly(bottom: 16.h),
          SizedBox(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.buttonRadius),
                  child: Image.asset(
                    widget.product.image,
                    height: 60.h,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          fontSize: AppSize.textMediumLarge,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                    Text(
                      widget.product.category,
                      style: TextStyle(
                          fontSize: AppSize.textSmallMedium,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey),
                    ),
                  ],
                ).paddingOnly(right: 10.w),
                Row(
                  children: [
                    Container(
                      height: 30.sp,
                      width: 30.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSize.buttonRadius,
                          ),
                          color: AppColors.white),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              quantity = controller.decreaseQuantity(quantity);
                              totalPriceWDF = widget.product.price * quantity;
                            });
                          },
                          icon: Text(
                            "−",
                            style: TextStyle(
                                fontSize: AppSize.textSmall,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                          fontSize: AppSize.textSmall,
                          fontWeight: FontWeight.w500),
                    ).paddingSymmetric(horizontal: 10.w),
                    Container(
                      height: 30.sp,
                      width: 30.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSize.buttonRadius,
                          ),
                          color: AppColors.white),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              quantity = controller.increaseQuantity(quantity);
                              totalPriceWDF = widget.product.price * quantity;
                            });
                          },
                          icon: Text(
                            "+",
                            style: TextStyle(
                                fontSize: AppSize.textSmall,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ).paddingOnly(bottom: 16.h),
          Divider(
            height: 1.h,
            color: AppColors.extraLight,
            indent: 20.w,
            endIndent: 20.w,
          ).paddingOnly(bottom: 16.h),
          Container(
            height: 60.h,
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.extraLight),
                borderRadius: BorderRadius.circular(AppSize.buttonRadius)),
            child: ListTile(
              leading: Icon(
                Iconsax.discount_shape,
                color: AppColors.button,
                size: AppSize.iconMedium,
              ),
              title: Text(
                "1 Discount is Applies",
                style: TextStyle(
                    fontSize: AppSize.textMedium, fontWeight: FontWeight.w500),
              ),
              trailing: SvgPicture.asset(
                AppStrings.svgArrowRight,
                height: 20.h,
                width: 20.w,
              ),
            ),
          ).paddingOnly(bottom: 16.h),
          Text(
            "Payment Summary",
            style: TextStyle(
                fontSize: AppSize.textMediumLarge, fontWeight: FontWeight.w500),
          ).paddingOnly(bottom: 16.h),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(
                        fontSize: AppSize.textMedium,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$ ${totalPriceWDF.toStringAsPrecision(5)}",
                    style: TextStyle(
                        fontSize: AppSize.textSmallMedium,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ).paddingOnly(bottom: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Fee",
                    style: TextStyle(
                        fontSize: AppSize.textMedium,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        "\$ 2.0",
                        style: TextStyle(
                            // update as this line through not center prpoerly
                            decoration: TextDecoration.lineThrough,
                            fontSize: AppSize.textSmallMedium,
                            fontWeight: FontWeight.w500),
                      ).paddingOnly(right: 4.w),
                      Text(
                        "\$ ${controller.deliveryFee}",
                        style: TextStyle(
                            fontSize: AppSize.textSmallMedium,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ]);
  }

  Widget buildPickupView() {
    return Center(
      child: Text("Pickup",
          style: TextStyle(
              fontSize: AppSize.textMediumLarge, fontWeight: FontWeight.w600)),
    );
  }
}

class OrderController extends GetxController {
  var address = "Enter your address".obs;
  var note = "Enter note".obs;
  var deliveryFee = 1.0.obs;

  void editAddress() {
    TextEditingController controller =
        TextEditingController(text: address.value);
    Get.defaultDialog(
      title: "Edit Address",
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: address.value),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          address.value = controller.text;
          Get.back();
        },
        child: Text("Save"),
      ),
    );
  }

  void addNote() {
    TextEditingController controller = TextEditingController(text: note.value);
    Get.defaultDialog(
      title: "Add Note",
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: note.value),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          note.value = controller.text;
          Get.back();
        },
        child: Text("Save"),
      ),
    );
  }

  int increaseQuantity(int quantity) {
    if (quantity <= 100) {
      quantity++;
    }
    return quantity;
  }

  int decreaseQuantity(int quantity) {
    if (quantity > 1) {
      quantity--;
    }

    return quantity;
  }

  double totalPrice(int quantity, double price) {
    double total = (quantity * price);
    if (quantity >= 1) total += deliveryFee.value;
    return total;
  }
}
