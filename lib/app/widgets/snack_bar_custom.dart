import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

snackBarCustom(
    {required title,
    required message,
    required colorText,
    required backgroundColor,
    required iconColor,
    required icon}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    icon: Icon(
      icon,
      color: iconColor,
    ),
    shouldIconPulse: true,
    colorText: colorText,
    snackPosition: SnackPosition.BOTTOM,
    mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.back();
          }
        },
        child: Text(
          'Close',
          style: GoogleFonts.comfortaa(color: colorText),
        )),
    barBlur: 20,
    isDismissible: true,
    duration: const Duration(seconds: 1),
  );
}
