import 'package:get/get.dart';
import 'package:where_the_food/app/modules/home/binding.dart';
import 'package:where_the_food/app/modules/home/view.dart';
import 'package:where_the_food/app/modules/welcome/view.dart';

import '../../data/local/manager/db_manager.dart';
import '../../utils/service.dart';
import '../welcome/binding.dart';
import 'state.dart';

class AuthorizedCheckLogic extends GetxController {
  final AuthorizedCheckState state = AuthorizedCheckState();

  @override
  Future<void> onInit() async {
    super.onInit();
    var userDB = await locator<AppDatabase>().getUser();
    // await locator<AppDatabase>().deleteUser(userDB);
    // userDB = await locator<AppDatabase>().getUser();
    if (userDB == null) {
      Get.offAll(() => WelcomePage(), binding: WelcomeBinding());
    } else {
      Get.offAll(() => HomePage(), binding: HomeBinding());
    }
  }
}
