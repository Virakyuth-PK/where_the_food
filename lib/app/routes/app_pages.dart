import 'package:get/get.dart';
import 'package:where_the_food/app/modules/cart/binding.dart';
import 'package:where_the_food/app/modules/cart/view.dart';
import 'package:where_the_food/app/modules/filter_category/binding.dart';
import 'package:where_the_food/app/modules/filter_category/view.dart';
import 'package:where_the_food/app/modules/home/binding.dart';
import 'package:where_the_food/app/modules/home/view.dart';
import 'package:where_the_food/app/modules/login/binding.dart';
import 'package:where_the_food/app/modules/login/view.dart';
import 'package:where_the_food/app/modules/product_detail/binding.dart';
import 'package:where_the_food/app/modules/product_detail/view.dart';
import 'package:where_the_food/app/modules/register/binding.dart';
import 'package:where_the_food/app/modules/register/view.dart';
import 'package:where_the_food/app/modules/welcome/binding.dart';
import 'package:where_the_food/app/modules/welcome/view.dart';

import '../modules/authorized_check/binding.dart';
import '../modules/authorized_check/view.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.AUTHORIZED_CHECK,
      page: () => AuthorizedCheckPage(),
      binding: AuthorizedCheckBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAIL,
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.FILTER_CATEGORY,
      page: () => FilterCategoryPage(),
      binding: FilterCategoryBinding(),
    ),
  ];
}
