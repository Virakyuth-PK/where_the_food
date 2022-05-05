import 'package:logger/logger.dart';
import 'package:where_the_food/app/data/api/api_utils.dart';
import 'package:where_the_food/app/models/request/login/login_model.dart';
import 'package:where_the_food/app/models/request/register/register_model.dart';
import 'package:where_the_food/app/models/response/category_detail/category_detail_model.dart';
import 'package:where_the_food/app/models/response/menu/menu_model.dart';
import 'package:where_the_food/app/models/response/user/user_model.dart';

import '../../models/response/category/category_model.dart';
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
    await Http().get(
      categories,
      onSuccess: (data) {
        var list = <CategoryModel>[];
        for (var item in data) {
          list.add(CategoryModel.fromJson(item));
        }
        return onSuccess(list);
      },
    );
  }

  Future<void> getCategoriesDetail({
    required String categoryId,
    required Function(List<Menu>) onSuccess,
  }) async {
    await Http().get(
      category + "/" + categoryId,
      onSuccess: (data) {
        var categoryDetail = CategoryDetailModel.fromJson(data);
        return onSuccess(categoryDetail.menu!);
      },
    );
  }
}
