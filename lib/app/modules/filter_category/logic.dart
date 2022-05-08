import 'package:get/get.dart';
import 'package:where_the_food/app/modules/home/logic.dart';

import '../../data/api/api.dart';
import '../../models/response/category/category_model.dart';
import '../../models/response/menu/menu_model.dart';
import 'state.dart';

class FilterCategoryLogic extends GetxController {
  final FilterCategoryState state = FilterCategoryState();
  final homeLogic = Get.find<HomeLogic>();
  List<int> listFilter = <int>[];
  List<CategoryModel> categoriesList = <CategoryModel>[];
  List<List<Menu>> categoryDetailListFilter = <List<Menu>>[];

  @override
  Future<void> onInit() async {
    super.onInit();
    listFilter.addAll(homeLogic.listFilter);
    update();
    for (var indexListFilter in listFilter) {
      categoriesList.add(homeLogic.categoriesList[indexListFilter]);
      update();
    }
    for (var indexListFilter in listFilter) {
      if (homeLogic.categoryDetailList[indexListFilter].isEmpty) {
        for (var indexCategoryList in categoriesList) {
          await getCategoryDetail(indexListFilter, indexCategoryList.sId!);
          update();
        }
      } else {
        categoryDetailListFilter.add(homeLogic.categoryDetailList[indexListFilter]);
        update();
      }
    }

    homeLogic.listFilter.clear();
    update();
  }

  getCategoryDetail(index, String sId) async {
    await Api().getCategoriesDetail(
        categoryId: sId,
        onSuccess: (data) {
          var result = data;
          // for (var item in data) {
          //   categoryDetailListFilter[index].addAll(data);
            update();
          // }
        });
  }
}
