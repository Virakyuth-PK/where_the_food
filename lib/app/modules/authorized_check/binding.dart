import 'package:get/get.dart';

import 'logic.dart';

class AuthorizedCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthorizedCheckLogic());
  }
}
