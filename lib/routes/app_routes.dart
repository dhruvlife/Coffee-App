import 'package:figmawc/core/screens/cart/cart_screen.dart';

import 'package:figmawc/core/screens/order/order_screen.dart';
import 'package:figmawc/core/screens/product_view/product_view_screen.dart';
import 'package:figmawc/routes/routes_name.dart';
import 'package:figmawc/core/screens/home/bottom_nav_menu.dart';
import 'package:figmawc/core/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: RoutesName.splash, page: () => SplashScreen()),
    GetPage(name: RoutesName.bottomMenu, page: () => BottomMenu()),
    GetPage(name: RoutesName.order, page: () => OrderScreen(product: Get.arguments,)),
    GetPage(name: RoutesName.productView, page: () => ProductViewScreen(product: Get.arguments,),),
    GetPage(name: RoutesName.cart, page: () => CartScreen(),),
  ];
}
