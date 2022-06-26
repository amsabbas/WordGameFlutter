import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../style/colors.dart';

class CustomSnackBar {
  static void showSuccessSnackBar(String title, String message) {
    Future.delayed(Duration.zero, () async {
      Get.snackbar(
        title,
        message,
        backgroundColor: AppColors.greenColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppColors.whiteColor),
        ),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 14, color: AppColors.whiteColor),
        ),
      );
    });
  }

  static void showFailureSnackBar(
      {required String title, required String message}) {
    Future.delayed(Duration.zero, () async {
      Get.snackbar(
        title,
        message,
        backgroundColor: AppColors.redColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppColors.whiteColor),
        ),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 14, color: AppColors.whiteColor),
        ),
      );
    });
  }
}
