import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:where_the_food/app/data/local/manager/db_manager.dart';
import 'package:where_the_food/app/modules/home/logic.dart';

import '../../models/response/menu/menu_model.dart';
import '../../utils/service.dart';
import 'state.dart';

class ProductDetailLogic extends GetxController {
  final ProductDetailState state = ProductDetailState();
  final homeLogic = Get.find<HomeLogic>();
  late MenuModel selectedProduct;
  var qty = 1.obs;
  var productAlreadyAdded = false;
  Cart? cartAdded;

  @override
  Future<void> onInit() async {
    super.onInit();
    selectedProduct = homeLogic.selectedProduct!;
    await checkProductAdded();
    update();
  }

  void onPressedAddToCart() async {
    if (cartAdded != null) {
      cartAdded!.qty = cartAdded!.qty + qty.value;
      await locator<AppDatabase>().updateCart(cartAdded!);
    } else {
      await locator<AppDatabase>().insertCart(Cart(
          itemId: selectedProduct.sId!,
          name: selectedProduct.name!,
          image: selectedProduct.image!,
          price: selectedProduct.price!,
          category: selectedProduct.category!,
          qty: qty.value));
    }

    qty.value = 1;
    update();
    cartAdded =  await checkProductAdded();
  }

  checkProductAdded() async {
    Logger().e("checkProductAdded");
    cartAdded = null;
    productAlreadyAdded = false;
    Logger().e("cartAdded :: $cartAdded");
    Logger().e("productAlreadyAdded :: $productAlreadyAdded");
    update();
    cartAdded =
        await locator<AppDatabase>().getWhereIdCart(selectedProduct.sId!);
    update();
    Logger().e("db cartAdded :: $cartAdded");
    if (cartAdded != null) {
      Logger().e("if cartAdded :: $cartAdded");
      productAlreadyAdded = true;
      Logger().e("if productAlreadyAdded :: $productAlreadyAdded");
      update();
    }
  }
}
