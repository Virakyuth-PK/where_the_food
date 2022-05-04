import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  var userNameController = TextEditingController();

  var isPasswordObscureText = true.obs;

  var passwordController = TextEditingController();

  void onPressedLogin() {}
}
