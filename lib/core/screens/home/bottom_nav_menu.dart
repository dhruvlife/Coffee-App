import 'package:figmawc/common/bottom_navmenu.dart';
import 'package:figmawc/core/screens/cart/cart_screen.dart';
import 'package:figmawc/core/screens/favourite/like.dart';
import 'package:figmawc/core/screens/home/home_screen.dart';
import 'package:figmawc/core/screens/map/map_screen.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    LikeScreen(),
    CartScreen(),
    MapScreen(),
  ];

  // Handles Bottom Navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem bottomNavBarItem(
      String svg, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        svg,
        width: 20.w,
        height: 20.h,
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(
            _selectedIndex == index ? AppColors.bottomNav : AppColors.black,
            BlendMode.srcIn),
        theme: SvgTheme(
            currentColor: _selectedIndex == index
                ? AppColors.bottomNav
                : AppColors.black),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavMenu(
        selectedItemColor: AppColors.bottomNav,
        containerColor: AppColors.white,
        currentIndex: _selectedIndex,
        items: [
          bottomNavBarItem(AppStrings.svgHome, AppStrings.home, 0),
          bottomNavBarItem(AppStrings.svgHeart, AppStrings.favourite, 1),
          bottomNavBarItem(AppStrings.svgBag, AppStrings.cart, 2),
          bottomNavBarItem(AppStrings.svgSearch, AppStrings.location, 3),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
