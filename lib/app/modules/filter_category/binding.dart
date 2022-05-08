import 'package:get/get.dart';

import 'logic.dart';

class FilterCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterCategoryLogic());
  }
}
