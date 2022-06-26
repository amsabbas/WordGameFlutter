import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/base/controller/audio_controller.dart';
import 'package:word_game/base/injection/general_injection.dart';
import 'package:word_game/base/language/language.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:word_game/base/widget/empty_app_bar.dart';

class LockedScreen extends StatelessWidget {
  final String title;
  final String desc;

  const LockedScreen({Key? key, required this.title, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: AppColors.defaultColor,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                getAppBar(context),
                getLockedDesc(context),
                getLockedButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBar(BuildContext context) {
    return Container(
      color: AppColors.redColor,
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                getIt<AudioController>().playButtonClickAudio();

                Get.back();
              },
              child: const Icon(
                Icons.close,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20, color: AppColors.whiteColor, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLockedDesc(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Text(
        desc,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontSize: 16, color: AppColors.whiteColor, height: 1.5),
      ),
    );
  }

  Widget getLockedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: Card(
          color: AppColors.blueLightColor,
          child: TextButton(
            onPressed: () async {
              getIt<AudioController>().playButtonClickAudio();
              Get.back();
            },
            child: Text(
              MessageKeys.dismiss.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16, color: AppColors.whiteColor, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
