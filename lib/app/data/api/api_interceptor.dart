// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../modules/login/binding.dart';
import '../../modules/login/view.dart';

getDioInterceptor(Dio dio) {
  return InterceptorsWrapper(
    onError: (e, handler) async {
      var msg = "asdasda";
      Logger().wtf(e.response!.statusCode);
      if (e.response != null) {
        if (e.response!.data != "") {
          msg = e.response!.data["message"].toString();
        } else {
          if (e.response!.statusMessage != "") {
            msg = e.response!.statusMessage!;
          }
        }
        if (e.response!.statusCode == 403) {
          if (e.response != null || e.response!.data != "") {
            msg = e.response!.data["error"].toString();
          }
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

      await EasyLoading.showError(msg);
      if (e.response?.statusCode == 401) {
        if (e.response == null || e.response!.data == "") {
          Logger().e(e.response);
          // await deleteAllDB();
          Get.offAll(() => LoginPage(), binding: LoginBinding());
        }
      }
      return handler.reject(e);
    },
    onRequest: (options, handler) async {
      await EasyLoading.show(
          status: 'Loading ...', maskType: EasyLoadingMaskType.black);
      return handler.next(options);
    },
    onResponse: (e, handler) async {
      await EasyLoading.showSuccess("Successful",
          duration: const Duration(microseconds: 1));
      return handler.next(e);
    },
  );
}
