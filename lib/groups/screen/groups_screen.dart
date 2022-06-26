import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:word_game/base/widget/empty_app_bar.dart';
import 'package:word_game/base/widget/locked_screen.dart';
import 'package:word_game/game/controller/game_controller.dart';
import 'package:word_game/levels/screen/levels_screen.dart';

import '../../base/controller/audio_controller.dart';
import '../../base/injection/general_injection.dart';
import '../../base/language/language.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late final GameController _gameController;

  @override
  void initState() {
    super.initState();
    _gameController = Get.put(getIt<GameController>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: AppColors.defaultColor,
        child: Column(
          children: [
            _appBar,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    groupButtonWidget(MessageKeys.firstGroupTitleKey.tr, 1),
                    groupButtonWidget(MessageKeys.secondGroupTitleKey.tr, 2),
                    groupButtonWidget(MessageKeys.thirdGroupTitleKey.tr, 3),
                    groupButtonWidget(MessageKeys.forthGroupTitleKey.tr, 4),
                    groupButtonWidget(MessageKeys.fifthGroupTitleKey.tr, 5),
                    groupButtonWidget(MessageKeys.sixthGroupTitleKey.tr, 6),
                    groupButtonWidget(MessageKeys.seventhGroupTitleKey.tr, 7),
                    groupButtonWidget(MessageKeys.eighthGroupTitleKey.tr, 8),
                    groupButtonWidget(MessageKeys.ninthGroupTitleKey.tr, 9),
                    groupButtonWidget(MessageKeys.tenthGroupTitleKey.tr, 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _appBar {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: AppColors.greenColor,
        width: double.infinity,
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              MessageKeys.selectGroupTitleKey.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20, color: AppColors.whiteColor, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget groupButtonWidget(text, index) {
    return Obx(() {
      late IconData iconData;
      if (_gameController.groupId.value == index) {
        iconData = Icons.play_arrow;
      } else if (_gameController.groupId.value > index) {
        iconData = Icons.done;
      } else {
        iconData = Icons.lock;
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          height: 65,
          width: double.infinity,
          child: Card(
            color: AppColors.tealColor,
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () async {
                getIt<AudioController>().playButtonClickAudio();
                if (iconData != Icons.lock) {
                  Get.to(() => LevelsScreen(text, index),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300));
                } else {
                  _showLockedDialog();
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: AppColors.blueLightColor,
                    height: double.infinity,
                    width: 50,
                    child: Icon(
                      iconData,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 20, color: AppColors.whiteColor, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
                        title: MessageKeys.groupLockedTitleKey.tr,
                        desc: MessageKeys.groupLockedDescKey.tr));
              },
            )),
        barrierDismissible: false,
      ),
    );
  }
}
