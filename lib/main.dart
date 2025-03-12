import 'package:figmawc/routes/app_routes.dart';
import 'package:figmawc/routes/routes_name.dart';
import 'package:figmawc/core/screens/splash_screen.dart';
import 'package:figmawc/utils/constants/app_strings.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appTitle,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          // home: ProductViewScreen(),
          home: SplashScreen(),
          initialRoute: RoutesName.splash,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
