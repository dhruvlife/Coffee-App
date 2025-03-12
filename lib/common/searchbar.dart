import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatelessWidget {
  final IconData leadingIconData;
  final String? suffixIconData;
  final VoidCallback? onSuffixAction;
  final String searchTitle;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    required this.leadingIconData,
    this.suffixIconData,
    required this.searchTitle,
    this.onSuffixAction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.07.sh,
      width: 1.sw,
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              textStyle: WidgetStateProperty.all(TextStyle(
                  color: AppColors.white, fontSize: AppSize.textMedium)),
              backgroundColor:
                  WidgetStateProperty.all(AppColors.searchBgContainer),
              leading: Icon(
                leadingIconData,
                size: AppSize.iconExtraLarge,
                color: AppColors.suffixIcon,
              ),
              hintText: searchTitle,
              hintStyle:
                  WidgetStateProperty.all(TextStyle(color: AppColors.white)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSize.searchBarRadius))),
              onChanged: onChanged,
            ),
          ),
          if (suffixIconData != null)
            Container(
              height: 0.065.sh,
              width: 0.12.sw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.searchBarRadius),
                  color: AppColors.button),
              child: IconButton(
                onPressed: onSuffixAction,
                color: AppColors.button,
                icon: Center(
                  child: SvgPicture.asset(
                    suffixIconData!,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.fill,
                    colorFilter:
                        ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ).paddingOnly(
              left: 16.w,
            ),
        ],
      ),
    );
  }
}
