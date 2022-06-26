import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/base/controller/audio_controller.dart';
import 'package:word_game/base/utils/constants.dart';
import 'package:word_game/base/utils/custom_dialog.dart';
import 'package:word_game/base/widget/custom_circular_progress_indicator.dart';
import 'package:word_game/game/screen/game_level_completed_screen.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:word_game/base/widget/empty_app_bar.dart';
import 'package:word_game/game/controller/game_controller.dart';
import 'package:word_game/game/screen/image_screen.dart';

import '../../base/injection/general_injection.dart';
import '../../base/language/language.dart';
import '../model/card_item.dart';

class GameScreen extends StatefulWidget {
  final int levelId;
  final int groupId;

  const GameScreen({Key? key, required this.groupId, required this.levelId})
      : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController _gameController;
  late final AudioController _audioController;
  final key = GlobalKey();

  late final Worker _levelCompletedWorker, _allLevelCompletedWorker;

  @override
  void initState() {
    super.initState();
    _gameController = Get.put(getIt<GameController>());
    _audioController = Get.put(getIt<AudioController>());

    _levelCompletedWorker =
        ever(_gameController.levelCompleted, (bool levelCompleted) {
      if (levelCompleted) {
        _showLevelCompletedDialog(false);
      }
    });

    _allLevelCompletedWorker =
        ever(_gameController.allLevelCompleted, (bool levelCompleted) {
      if (levelCompleted) {
        _showLevelCompletedDialog(true);
      }
    });

    _gameController.init(widget.levelId, widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmptyAppBar(),
        body: Obx(() {
          if (_gameController.levelInitialized.value == false) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.defaultColor,
              child: Center(
                child: CustomCircularProgressIndicator.getIndicator(
                    context, AppColors.whiteColor),
              ),
            );
          } else {
            return Container(
                color: AppColors.defaultColor,
                child: Column(
                  children: [_imageWidget(), _buttonsWidget(), _getWords()],
                ));
          }
        }));
  }

  Widget _imageWidget() {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(() => Image.asset(
                "assets/images/game/" +
                    _gameController
                        .levels![_gameController.currentLevelId.value +
                            Constants.levelPerGroup *
                                (_gameController.currentGroupId.value - 1) -
                            1]
                        .imageName,
                height:
                    deviceHeight <= 550 ? deviceHeight / 5 : deviceHeight / 4.2,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              )),
          Container(
            color: AppColors.darkGrayColor,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _audioController.playButtonClickAudio();
                      _showHelpDialog();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                            _gameController.helpValue.value.toString(),
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontSize: 16,
                                      color: AppColors.yellowColor,
                                    ))),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.wb_sunny_outlined,
                          color: AppColors.yellowColor,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ImageScreen("assets/images/game/" +
                          _gameController
                              .levels![_gameController.currentLevelId.value +
                                  Constants.levelPerGroup *
                                      (_gameController.currentGroupId.value -
                                          1) -
                                  1]
                              .imageName));
                    },
                    child: const Icon(
                      Icons.zoom_out_map_outlined,
                      color: AppColors.yellowColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getWords() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: SizedBox(
        height: 70,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 30,
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0),
          itemBuilder: (_, index) {
            return Obx(() => Center(
                  child: Text(
                      index > _gameController.wordsResult.length - 1
                          ? "- - - - - -"
                          : _gameController.wordsResult[index],
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 14, color: AppColors.yellowColor)),
                ));
          },
          itemCount: _gameController
              .levels![_gameController.currentLevelId.value +
                  Constants.levelPerGroup *
                      (_gameController.currentGroupId.value - 1) -
                  1]
              .result
              .length,
        ),
      ),
    );
  }

  void _showHelpDialog() {
    if (_gameController.helpValue.value == 0) {
      CustomDialog.showMessageDialog(context, MessageKeys.attention.tr,
          MessageKeys.gameHelpEmptyMessage.tr, MessageKeys.dismiss.tr, () {});
    } else {
      CustomDialog.showConfirmationDialog(context, MessageKeys.attention.tr,
          MessageKeys.gameHelpConfirmationMessage.tr, MessageKeys.yes.tr, () {
        _gameController.applyGameHelp();
      }, MessageKeys.no.tr, () {});
    }
  }

  Widget _buttonsWidget() {
    return Obx(() {
      List<String> items = _gameController.newPuzzle.value.toList();
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Listener(
            onPointerDown: (event) {
              _gameController.detectTapedItem(event, key);
            },
            onPointerMove: (event) {
              _gameController.detectTapedItem(event, key);
            },
            onPointerUp: (event) => _gameController.clearTapedSelection(event),
            child: GridView.builder(
                key: key,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisExtent: MediaQuery.of(context).size.height / 14),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                padding: const EdgeInsets.all(4.0),
                itemBuilder: (context, index) {
                  return Obx(
                    () => CardItemRender(
                      value: items[index].toString(),
                      index: index,
                      child: Card(
                        color:
                            _gameController.getTapedIndexList().contains(index)
                                ? AppColors.orangeLightColor
                                : Colors.white,
                        child: Center(
                          child: Text(items[index].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 14)),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
    });
  }

  void _showLevelCompletedDialog(bool isAllLevelCompleted) {
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
                    height: height / 2,
                    child: GameLevelCompletedScreen(
                      level: _gameController.currentLevelId.value +
                          Constants.levelPerGroup *
                              (_gameController.currentGroupId.value - 1),
                      isAllLevelCompleted: isAllLevelCompleted,
                      nextCallback: () {
                        _gameController.updateLevel();
                        if (isAllLevelCompleted) {
                          Get.close(2);
                        } else {
                          _gameController.init(-1, -1);
                          Get.back();
                        }
                      },
                    ));
              },
            )),
        barrierDismissible: false,
      ),
    );
  }

  @override
  void dispose() {
    _levelCompletedWorker.dispose();
    _allLevelCompletedWorker.dispose();
    super.dispose();
  }
}
