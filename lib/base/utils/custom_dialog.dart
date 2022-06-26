import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/base/controller/audio_controller.dart';
import 'package:word_game/base/injection/general_injection.dart';
import 'package:word_game/base/style/colors.dart';

class CustomDialog {
  static void showMessageDialog(BuildContext context, String title,
      String message, String positiveButtonTitle, Function positiveCallBack) {
    Future.delayed(
      Duration.zero,
      () => Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: AppColors.tealColor,
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.whiteColor, fontSize: 20)),
            content: Text(message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.whiteColor, fontSize: 18)),
            actions: <Widget>[
              TextButton(
                  child: Text(positiveButtonTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppColors.whiteColor)),
                  onPressed: () {
                    getIt<AudioController>().playButtonClickAudio();
                    Get.back();
                    positiveCallBack.call();
                  }),
            ],
          ),
        ),
        barrierDismissible: false,
      ),
    );
  }

  static void showConfirmationDialog(
      BuildContext context,
      String title,
      String message,
      String positiveButtonTitle,
      Function positiveCallBack,
      String negativeButtonTitle,
      Function negativeCallBack) {
    Future.delayed(
      Duration.zero,
      () => Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: AppColors.tealColor,
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.whiteColor, fontSize: 20)),
            content: Text(message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.whiteColor, fontSize: 18)),
            actions: <Widget>[
              TextButton(
                  child: Text(positiveButtonTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppColors.whiteColor)),
                  onPressed: () {
                    getIt<AudioController>().playButtonClickAudio();
                    Get.back();
                    positiveCallBack.call();
                  }),
              TextButton(
                  child: Text(negativeButtonTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppColors.whiteColor)),
                  onPressed: () {
                    getIt<AudioController>().playButtonClickAudio();
                    Get.back();
                    negativeCallBack.call();
                  }),
            ],
          ),
        ),
        barrierDismissible: false,
      ),
    );
  }
}
