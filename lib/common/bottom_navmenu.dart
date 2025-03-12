import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavMenu extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final Color containerColor;
  final Color selectedItemColor;
  final ValueChanged<int> onTap;

  const BottomNavMenu({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.containerColor,
    required this.onTap,
    required this.selectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width <= 800 ? 80.h : 0.1.sh,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.bottomNavBarRadius),
          topRight: Radius.circular(AppSize.bottomNavBarRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.bottomNavShadow,
            blurRadius: 10.r,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.bottomNavCurvRadius),
          topRight: Radius.circular(AppSize.bottomNavCurvRadius),
        ),
        child: BottomNavigationBar(
          items: items,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: AppSize.textMedium),
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: selectedItemColor,
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.grey,
          backgroundColor: containerColor,
          elevation: 20,
        ),
      ),
    );
  }
}
