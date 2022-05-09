import 'package:logger/logger.dart';
import 'package:where_the_food/app/data/api/api_utils.dart';
import 'package:where_the_food/app/data/local/manager/db_manager.dart';
import 'package:where_the_food/app/models/request/login/login_model.dart';
import 'package:where_the_food/app/models/request/register/register_model.dart';
import 'package:where_the_food/app/models/response/category_detail/category_detail_model.dart';
import 'package:where_the_food/app/models/response/menu/menu_model.dart';
import 'package:where_the_food/app/models/response/order/order_model.dart';
import 'package:where_the_food/app/models/response/order_history/order_history.dart';
import 'package:where_the_food/app/models/response/user/user_model.dart';

import '../../models/request/order_item/order_item_model.dart';
import '../../models/response/category/category_model.dart';
import '../../utils/service.dart';
import 'http.dart';

class Api {
  Future<void> postLogin(
    LoginModel loginModel, {
    required Function(UserModel) onSuccess,
  }) async {
    await Http().post(login, body: loginModel, onSuccess: (data) {
      var userModel = UserModel.fromJson(data);
      return onSuccess(userModel);
    });
  }

  Future<void> postRegister(
    RegisterModel registerModel, {
    required Function(UserModel) onSuccess,
  }) async {
    await Http().post(register, body: registerModel, onSuccess: (data) {
      var userModel = UserModel.fromJson(data);
      return onSuccess(userModel);
    });
  }

  Future<void> getCategories({
    required Function(List<CategoryModel>) onSuccess,
  }) async {
    await Http().get(categories, onSuccess: (data) {
      var list = <CategoryModel>[];
      for (var item in data) {
        list.add(CategoryModel.fromJson(item));
      }
      return onSuccess(list);
    });
  }

  Future<void> getCategoriesDetail(
      {required String categoryId,
      required Function(List<MenuModel>) onSuccess}) async {
    await Http().get(category + "/" + categoryId, onSuccess: (data) {
      var categoryDetail = CategoryDetailModel.fromJson(data);
      return onSuccess(categoryDetail.menu!);
    });
  }

  Future<void> postMakeOrder(
      {required OrderItemModel orderItemModel,
      required Function(OrderModel) onSuccess}) async {
    var user = await locator<AppDatabase>().getUser();
    Logger().w(user);
    await Http().post(orders, body: orderItemModel, token: user.token,
        onSuccess: (data) {
      var orderModel = OrderModel.fromJson(data);
      return onSuccess(orderModel);
    });
  }

  Future<void> getAllOrder(
      {
      required Function(List<OrderHistoryModel>) onSuccess}) async {
    var user = await locator<AppDatabase>().getUser();
    Logger().w(user);
    await Http().get(orders, token: user.token,
        onSuccess: (data) {
      List<OrderHistoryModel> result = <OrderHistoryModel>[];
      for (var item in data) {
        result.add(OrderHistoryModel.fromJson(item));
      }
      return onSuccess(result);
    });
  }
}
