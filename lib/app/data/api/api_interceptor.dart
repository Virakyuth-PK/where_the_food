// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../modules/login/binding.dart';
import '../../modules/login/view.dart';
import '../../utils/service.dart';
import '../local/manager/db_manager.dart';

getDioInterceptor(Dio dio, {required bool showLoading}) {
  return InterceptorsWrapper(
    onError: (e, handler) async {
      var msg = "";
      Logger().wtf(e.response!.statusCode);
      if (e.response != null) {
        if (e.response!.statusCode == 403) {
          if (e.response != null || e.response!.data != "") {
            msg = e.response!.data["error"].toString();
          }
        }
        if (e.response!.statusCode == 401) {
          msg = e.response!.statusMessage!;
        }
      } else {
        if (e.message != '') {
          if (e.message == "Connecting timed out [10000ms]") {
            msg = "Connection TimeOut!";
          } else {
            msg = e.message;
          }
          Logger().e(e.message);
        }
      }

      if (showLoading) {
        await EasyLoading.showError(msg);
      }
      if (e.response!.statusCode == 401) {
        await locator<AppDatabase>().deleteUser();
        await locator<AppDatabase>().clearCart();
        Get.offAll(() => LoginPage(), binding: LoginBinding());
      }
      return handler.reject(e);
    },
    onRequest: (options, handler) async {
    if(showLoading) {
      await EasyLoading.show(
          status: 'Loading ...', maskType: EasyLoadingMaskType.black);
    }
      return handler.next(options);
    },
    onResponse: (e, handler) async {
      if(showLoading) {
        await EasyLoading.showSuccess("Successful",
            duration: const Duration(microseconds: 1));
      }
      return handler.next(e);
    },
  );
}
