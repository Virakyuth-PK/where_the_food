import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_the_food/app/data/api/api.dart';
import 'package:where_the_food/app/data/local/manager/db_manager.dart';
import 'package:where_the_food/app/models/response/category/category_model.dart';
import 'package:where_the_food/app/modules/product_detail/view.dart';
import 'package:where_the_food/app/utils/color.dart';
import 'package:where_the_food/app/utils/service.dart';

import '../../models/response/menu/menu_model.dart';
import '../../widgets/button_custom.dart';
import '../product_detail/binding.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  var searchController = TextEditingController();

  var selectedCategoryIndex = 0;

  var pageController = PageController();

  Menu? selectedProduct;

  void onPressedFilter() {}

  void onPressedAddToCart() {}

  late User userLocal;
  List<CategoryModel> categoriesList = <CategoryModel>[];
  List<List<Menu>> categoryDetailList = <List<Menu>>[];

  @override
  void onInit() async {
    super.onInit();
    userLocal = await locator<AppDatabase>().getUser();
    await getCategories();
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
                      SizedBox(
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
                        onPress: () {},
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
                                  offset: Offset(0, 4),
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
          List<Menu> eachListCategoryDetail = <Menu>[];
          categoryDetailList.add(eachListCategoryDetail);
        }
        await getCategoryDetail(0);
        update();
      },
    );
  }

  Future<void> onPressedCategory(int index) async {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    selectedCategoryIndex = index;
    if (categoryDetailList[selectedCategoryIndex].length == 0) {
      await getCategoryDetail(index);
    }
    update();
  }

  getCategoryDetail(index) async {
    await Api().getCategoriesDetail(
        categoryId: categoriesList[index].sId!,
        onSuccess: (data) {
          categoryDetailList[index].addAll(data);
          update();
        });
  }

  void onPressedProduct(Menu categoryDetailList) {
    selectedProduct = categoryDetailList;
    update();
    Get.to(() => ProductDetailPage(), binding: ProductDetailBinding());
  }
}
