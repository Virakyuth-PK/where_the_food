import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:where_the_food/app/modules/home/logic.dart';

import '../../data/api/api.dart';
import '../../models/response/category/category_model.dart';
import '../../models/response/menu/menu_model.dart';
import 'state.dart';

class FilterCategoryLogic extends GetxController {
  final FilterCategoryState state = FilterCategoryState();
  final homeLogic = Get.find<HomeLogic>();
  late List<CategoryModel> listFilter = <CategoryModel>[];
  late List<List<MenuModel>> categoryDetailList = <List<MenuModel>>[];

  @override
  Future<void> onInit() async {
    super.onInit();
    listFilter.addAll(homeLogic.listFilter);
    update();
    await getCategoryDetail();
    homeLogic.listFilter.clear();
    update();
  }

  getCategoryDetail() async {
    for (var eachCategory in listFilter) {
      await Api().getCategoriesDetail(
          categoryId: eachCategory.sId!,
          onSuccess: (data) async {
            var eachCategoryDetail = <MenuModel>[];
            eachCategoryDetail.addAll(data);
            categoryDetailList.add(eachCategoryDetail);
            update();
          });
    }
  }
}
