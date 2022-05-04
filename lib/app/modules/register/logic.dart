import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();

  var userNameController = TextEditingController();

  var fullNameController = TextEditingController();

  var passwordController = TextEditingController();

  var isPasswordObscureText = true.obs;

  void onPressedRegister() {}

  void onPressedDateOfBirth() {}
}
