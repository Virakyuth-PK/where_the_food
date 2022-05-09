import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:where_the_food/app/data/api/api.dart';
import 'package:where_the_food/app/data/local/manager/db_manager.dart';
import 'package:where_the_food/app/models/request/order_item/order_item_model.dart';
import 'package:where_the_food/app/modules/product_detail/logic.dart';

import '../../utils/color.dart';
import '../../utils/service.dart';
import '../../widgets/snack_bar_custom.dart';
import 'state.dart';

class CartLogic extends GetxController {
  final CartState state = CartState();
  var productDetailLogic;
  List<Cart>? cartList;
  var total = 0.0;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (Get.arguments == "From Product Detail") {
      productDetailLogic = Get.find<ProductDetailLogic>();
    }
    update();
    await updateCartList();
  }

  Future<void> onPressedCheckOut() async {
    if (cartList!.length > 0) {
      await updateCartList();
      List<String> listItemId = <String>[];
      for (var item in cartList!) {
        listItemId.add(item.itemId);
        update();
      }
      Logger().i("listItemId :: $listItemId");

      await Api().postMakeOrder(
          orderItemModel: OrderItemModel(items: listItemId),
          onSuccess: (data) async {
            await locator<AppDatabase>().clearCart();
            await updateCartList();
            snackBarCustom(
                title: "Order Completed",
                message: "You can check the order items in History!",
                backgroundColor: halfMainColor,
                colorText: Colors.white,
                iconColor: Colors.white,
                icon: Icons.check_circle_outline_rounded);
          });
    }
  }

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

  Future<void> clearCart() async {
    await locator<AppDatabase>().clearCart();
    await updateCartList();
  }

  Future<void> checkUpdatedCartOnLastPage() async {
    if (productDetailLogic != null) {
      await productDetailLogic.checkProductAdded();
    }
  }
}
