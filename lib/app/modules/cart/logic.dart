import 'package:get/get.dart';
import 'package:where_the_food/app/data/local/manager/db_manager.dart';

import '../../utils/service.dart';
import 'state.dart';

class CartLogic extends GetxController {
  final CartState state = CartState();
  List<Cart>? cartList;
  var total = 0.0;

  @override
  Future<void> onInit() async {
    super.onInit();
    await updateCartList();
  }

  void onPressedCheckOut() {}

  Future<void> onPressedMinus(Cart cartList) async {
    if (cartList.qty == 1) {
      await locator<AppDatabase>().deleteCart(cartList);
      update();
    } else {
      cartList.qty--;
      update();
      await locator<AppDatabase>().updateCart(cartList);
      update();
    }
    await updateCartList();
  }

  Future<void> onPressedAdd(Cart cartList) async {
    cartList.qty++;
    update();
    await locator<AppDatabase>().updateCart(cartList);
    update();
    await updateCartList();
  }

  void sumTotal() {
    total = 0;
    update();
    for (var item in cartList!) {
      total += double.parse(item.price) * item.qty;
    }
    update();
  }

  updateCartList() async {
    cartList = await locator<AppDatabase>().getAllCart();
    update();
    Future.delayed(const Duration(milliseconds: 10), () {
      sumTotal();
    });
  }
}
