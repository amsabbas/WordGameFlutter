import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/game/screen/game_screen.dart';

import '../../base/controller/audio_controller.dart';
import '../../base/injection/general_injection.dart';
import '../../base/language/language.dart';
import '../../base/style/colors.dart';
import '../../base/widget/locked_screen.dart';

class LevelItemWidget extends StatelessWidget {
  final String title;
  final int groupId;
  final int levelId;
  final IconData icon;
  final Color iconColor;

  const LevelItemWidget(
      {Key? key,
      required this.title,
      required this.icon,
      required this.groupId,
      required this.levelId,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<AudioController>().playButtonClickAudio();
        if (icon != Icons.lock) {
          Get.to(
              () => GameScreen(
                    groupId: groupId,
                    levelId: levelId,
                  ),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 300));
        } else {
          _showLockedDialog();
        }
      },
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          color: AppColors.darkGrayColor,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: 8,
                color: iconColor,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: iconColor,
                      size: 35,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLockedDialog() {
    Future.delayed(
      Duration.zero,
      () => Get.dialog(
        AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Builder(
              builder: (context) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;
                return SizedBox(
                    width: width - width * 0.1,
                    height: height / 3,
                    child: LockedScreen(
                        title: MessageKeys.levelLockedTitleKey.tr,
                        desc: MessageKeys.levelLockedDescKey.tr));
              },
            )),
        barrierDismissible: false,
      ),
    );
  }
}
