import 'package:get/get.dart';
import 'package:where_the_food/app/modules/home/binding.dart';
import 'package:where_the_food/app/modules/home/view.dart';
import 'package:where_the_food/app/modules/welcome/view.dart';

import '../welcome/binding.dart';
import 'state.dart';

class AuthorizedCheckLogic extends GetxController {
  final AuthorizedCheckState state = AuthorizedCheckState();

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1), () {
      // Get.offAll(() => WelcomePage(), binding: WelcomeBinding());
      Get.offAll(() => HomePage(), binding: HomeBinding());
    });
  }
}
