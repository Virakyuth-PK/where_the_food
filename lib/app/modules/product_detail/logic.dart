import 'package:get/get.dart';
import 'package:where_the_food/app/data/local/manager/db_manager.dart';
import 'package:where_the_food/app/modules/home/logic.dart';

import '../../models/response/menu/menu_model.dart';
import '../../utils/service.dart';
import 'state.dart';

class ProductDetailLogic extends GetxController {
  final ProductDetailState state = ProductDetailState();
  final homeLogic = Get.find<HomeLogic>();
  late Menu selectedProduct;
  var qty = 1.obs;

  @override
  void onInit() {
    super.onInit();
    selectedProduct = homeLogic.selectedProduct!;
    update();
  }

  void onPressedAddToCart() async {
    await locator<AppDatabase>().insertCart(Cart(
        itemId: selectedProduct.sId!,
        name: selectedProduct.name!,
        image: selectedProduct.image!,
        price: selectedProduct.price!,
        category: selectedProduct.category!,
        qty: qty.value));
    qty.value = 1;
    update();
    await locator<AppDatabase>().getAllCart();
  }
}
