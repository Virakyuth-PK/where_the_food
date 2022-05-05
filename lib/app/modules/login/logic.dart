import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_the_food/app/data/api/api.dart';
import 'package:where_the_food/app/models/request/login/login_model.dart';
import 'package:where_the_food/app/models/response/user/user_model.dart';
import 'package:where_the_food/app/modules/home/binding.dart';
import 'package:where_the_food/app/modules/home/view.dart';

import '../../data/local/manager/db_manager.dart';
import '../../utils/service.dart';
import '../../widgets/snack_bar_custom.dart';
import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  var userNameController = TextEditingController();

  var isPasswordObscureText = true.obs;

  var passwordController = TextEditingController();

  var userNameFocusNode = FocusNode();

  var passwordFocusNode = FocusNode();

  Future<void> onPressedLogin() async {
    if (userNameFocusNode.hasFocus) {
      userNameFocusNode.unfocus();
    }
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    }
    if (userNameController.text.isEmpty) {
      snackBarCustom(
          message: 'Username Empty!',
          colorText: Colors.red,
          backgroundColor: Colors.white,
          title: 'Sorry',
          icon: Icons.error);
      return;
    }
    if (passwordController.text.isEmpty) {
      snackBarCustom(
          message: 'Password Empty!',
          colorText: Colors.red,
          backgroundColor: Colors.white,
          title: 'Sorry',
          icon: Icons.error);
      return;
    }
    await Api().postLogin(
      LoginModel(
          username: userNameController.text, password: passwordController.text),
      onSuccess: (UserModel data) async {
        await locator<AppDatabase>().insertUser(User.fromJson(data.toJson()));
        Get.offAll(() => HomePage(), binding: HomeBinding());
      },
    );
  }
}
