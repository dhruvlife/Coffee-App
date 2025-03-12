
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CartDivider extends StatelessWidget {
  const CartDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2,
      color: AppColors.extraLight,
    );
  }
}