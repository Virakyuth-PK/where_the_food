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
  List<CategoryModel> listFilter = <CategoryModel>[];
  List<List<Menu>> categoryDetailList = <List<Menu>>[];

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
          onSuccess: (data) {
            var eachCategoryDetail = <Menu>[];
            eachCategoryDetail.addAll(data);
            categoryDetailList.add(eachCategoryDetail);
            update();
          });
    }
  }
}
