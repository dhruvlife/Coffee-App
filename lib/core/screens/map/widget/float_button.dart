import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FloatButton({
    super.key,required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.button,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(),
        child: Icon(
          Icons.location_on,
          size: AppSize.iconExtraLarge,
          color: AppColors.white,
        ),
      ),
    );
  }
}