import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../base/language/language.dart';
import '../../base/style/colors.dart';
import 'package:get/get.dart';

import '../../base/utils/asset_resource.dart';
import '../../base/widget/empty_app_bar.dart';

class GameLevelCompletedScreen extends StatelessWidget {
  final int level;
  final Function nextCallback;
  final bool isAllLevelCompleted;

  const GameLevelCompletedScreen(
      {Key? key,
      required this.isAllLevelCompleted,
      required this.level,
      required this.nextCallback})
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
          child: Column(
            children: [
              _getAppBar(context),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getLevelCompletedTextWidget(context),
                    _lottieWidget(context),
                    _getNextButtonWidget(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAppBar(BuildContext context) {
    return Container(
      color: AppColors.greenColor,
      width: double.infinity,
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Text(
            MessageKeys.levelTitleKey.tr + " $level",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 20, color: AppColors.whiteColor, height: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _getLevelCompletedTextWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(MessageKeys.gameLevelCompletedMessage.tr,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 16,
                color: AppColors.whiteColor,
              )),
    );
  }

  Widget _lottieWidget(BuildContext context) {
    return Expanded(
      child: Lottie.asset(
          isAllLevelCompleted
              ? AssetResource.gameAllLevelCompletedAnimationPath
              : AssetResource.gameLevelCompletedAnimationPath,
          repeat: false),
    );
  }

  Widget _getNextButtonWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.greenColor,
      child: TextButton(
        onPressed: () async {
          nextCallback.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isAllLevelCompleted
                    ? MessageKeys.dismiss.tr
                    : MessageKeys.next.tr,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 20, color: AppColors.whiteColor, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
