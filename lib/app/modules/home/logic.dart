import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  var searchController = TextEditingController();

  var selectedCategoryIndex = 0;

  void onPressedFilter() {}

  void onPressedAddToCart() {}
}
