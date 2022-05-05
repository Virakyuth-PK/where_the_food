import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBarCustom(
    {required title,
    required message,
    required colorText,
    required backgroundColor,
    required icon}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    icon: Icon(icon),
    shouldIconPulse: true,
    colorText: colorText,
    mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.back();
          }
        },
        child: Text(
          'Close',
          style: Theme.of(Get.overlayContext!).textTheme.caption,
        )),
    barBlur: 20,
    isDismissible: true,
    duration: const Duration(seconds: 3),
  );
}
