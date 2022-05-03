import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  await setupLocator();
  runApp(
    KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: GetMaterialApp(
        enableLog: true,
        defaultTransition: Transition.cupertino,
        popGesture: Get.isPopGestureEnable,
        initialRoute: Routes.AUTHORIZED_CHECK,
        getPages: AppPages.pages,
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
      ),
    ),
  );
}
