import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:where_the_food/app/data/api/api.dart';
import 'package:where_the_food/app/data/local/manager/db_manager.dart';
import 'package:where_the_food/app/models/response/category/category_model.dart';
import 'package:where_the_food/app/modules/filter_category/binding.dart';
import 'package:where_the_food/app/modules/filter_category/view.dart';
import 'package:where_the_food/app/modules/product_detail/view.dart';
import 'package:where_the_food/app/modules/welcome/binding.dart';
import 'package:where_the_food/app/modules/welcome/view.dart';
import 'package:where_the_food/app/utils/color.dart';
import 'package:where_the_food/app/utils/service.dart';

import '../../models/response/menu/menu_model.dart';
import '../../widgets/button_custom.dart';
import '../../widgets/snack_bar_custom.dart';
import '../product_detail/binding.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  var searchController = TextEditingController();
  var selectedCategoryIndex = 0;
  var pageController = PageController();
  MenuModel? selectedProduct;
  Cart? cartAdded;
  late User userLocal;
  List<CategoryModel> categoriesList = <CategoryModel>[];
  List<List<MenuModel>> categoryDetailList = <List<MenuModel>>[];
  List<CategoryModel> listFilter = <CategoryModel>[];

  @override
  void onInit() async {
    super.onInit();
    userLocal = await locator<AppDatabase>().getUser();
    await getCategories();
    update();
  }

  void onPressedFilter() {
    showGeneralDialog(
      barrierLabel: "Filter",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(
                      left: 40, top: 20, right: 20, bottom: 20),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Filter By Category",
                            style: GoogleFonts.fredokaOne(fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 400,
                        child: ListView.builder(
                          itemCount: categoriesList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: GetBuilder<HomeLogic>(
                                builder: (logic) {
                                  var thisItemIsAddedFilter = false;
                                  if (listFilter.isNotEmpty) {
                                    for (var item in listFilter) {
                                      if (item == categoriesList[index]) {
                                        thisItemIsAddedFilter = true;
                                      }
                                    }
                                  }
                                  return ButtonCustom(
                                    toolTip: categoriesList[index].name!,
                                    onPress: () {
                                      if (thisItemIsAddedFilter) {
                                        listFilter
                                            .remove(categoriesList[index]);
                                      } else {
                                        listFilter.add(categoriesList[index]);
                                      }
                                      update();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color: thisItemIsAddedFilter
                                            ? halfMainColor
                                            : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: thisItemIsAddedFilter
                                                  ? shadowColor
                                                  : Colors.transparent,
                                              offset: const Offset(0, 4),
                                              blurRadius: 4)
                                        ],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        children: [
                                          Center(
                                            child: Text(
                                              categoriesList[index].name!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: thisItemIsAddedFilter
                                                    ? Colors.white
                                                    : Colors.black54,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          thisItemIsAddedFilter
                                              ? const Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: Colors.white,
                                                )
                                              : const SizedBox.shrink()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonCustom(
                        toolTip: 'Done',
                        onPress: () {
                          Get.back();
                          Get.to(() => FilterCategoryPage(),
                              binding: FilterCategoryBinding());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: halfMainColor,
                            boxShadow: [
                              BoxShadow(
                                  color: shadowColor,
                                  offset: const Offset(0, 4),
                                  blurRadius: 4)
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Done',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            margin: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  Future<void> onPressedAddToCart(MenuModel product) async {
    await checkProductAdded(product);
    update();
    if (cartAdded != null) {
      cartAdded!.qty = cartAdded!.qty + 1;
      await locator<AppDatabase>().updateCart(cartAdded!);
      snackBarCustom(
          title: "Cart Updated",
          message: "Product added 1 more successfully!",
          backgroundColor: halfMainColor,
          colorText: Colors.white,
          iconColor: Colors.white,
          icon: Icons.add_shopping_cart_rounded);
    } else {
      await locator<AppDatabase>().insertCart(Cart(
          itemId: product.sId!,
          name: product.name!,
          image: product.image!,
          price: product.price!,
          category: product.category!,
          qty: 1));
      snackBarCustom(
          title: "Cart Added",
          message: "Product added successfully!",
          backgroundColor: halfMainColor,
          colorText: Colors.white,
          iconColor: Colors.white,
          icon: Icons.add_shopping_cart_rounded);
    }
  }

  checkProductAdded(MenuModel product) async {
    cartAdded = await locator<AppDatabase>().getWhereIdCart(product.sId!);
    update();
  }

  void onPressedAccount() {
    showGeneralDialog(
      barrierLabel: "Account",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(
                      left: 40, top: 20, right: 20, bottom: 20),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Account Detail",
                            style: GoogleFonts.fredokaOne(fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Full Name : " + userLocal.fullName,
                        style: GoogleFonts.comfortaa(fontSize: 17.5),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Date Of Birth : " + userLocal.dateOfBirth,
                        style: GoogleFonts.comfortaa(fontSize: 17.5),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      ButtonCustom(
                        toolTip: 'Logout',
                        onPress: () async {
                          await locator<AppDatabase>().deleteUser();
                          await locator<AppDatabase>().clearCart();
                          Get.offAll(() => WelcomePage(),
                              binding: WelcomeBinding());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: shadowColor,
                                  offset: const Offset(0, 4),
                                  blurRadius: 4)
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                color: Colors.black87,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            margin: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  getCategories() async {
    await Api().getCategories(
      onSuccess: (data) async {
        categoriesList.addAll(data);
        for (var item in data) {
          List<MenuModel> eachListCategoryDetail = <MenuModel>[];
          categoryDetailList.add(eachListCategoryDetail);
        }
        await getCategoryDetail(0);
        update();
      },
    );
  }

  Future<void> onPressedCategory(int index) async {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    selectedCategoryIndex = index;
    if (categoryDetailList[selectedCategoryIndex].length == 0) {
      await getCategoryDetail(index);
    }
    update();
  }

  getCategoryDetail(index) async {
    Logger().e("getCategoryDetail home");
    await Api().getCategoriesDetail(
        categoryId: categoriesList[index].sId!,
        onSuccess: (data) {
          categoryDetailList[index].addAll(data);
          update();
        });
  }

  void onPressedProduct(MenuModel categoryDetailList) {
    selectedProduct = categoryDetailList;
    update();
    Get.to(() => ProductDetailPage(), binding: ProductDetailBinding());
  }
}
