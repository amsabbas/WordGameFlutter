import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/base/controller/audio_controller.dart';
import 'package:word_game/base/controller/game_db_controller.dart';
import '../../base/injection/general_injection.dart';
import '../../base/model/game_settings.dart';
import '../../base/model/level.dart';
import '../../base/utils/constants.dart';
import '../../base/utils/shared_preference.dart';
import '../../search/word_search.dart';
import '../model/card_item.dart';
import 'package:flutter/rendering.dart';

class GameController extends GetxController {
  SharedPrefs sharedPrefs;
  late final GameDBController _gameDBController;
  late final AudioController _audioController;
  late List<String> wordsList;
  late Rx<WSNewPuzzle> newPuzzle;
  final RxList<List<CardItem>> trackTaped = <List<CardItem>>[].obs;
  final RxList<String> wordsResult = <String>[].obs;
  late final RxInt helpValue;
  late final RxBool levelCompleted = false.obs;
  late final RxBool allLevelCompleted = false.obs;
  final RxInt levelId = 1.obs;
  final RxInt currentLevelId = 1.obs;
  final RxInt groupId = 1.obs;
  final RxInt currentGroupId = 1.obs;
  Rx<bool> levelInitialized = false.obs;
  List<Level>? levels;

  GameController({required this.sharedPrefs}) {
    _gameDBController = Get.put(getIt<GameDBController>());
    _audioController = Get.put(getIt<AudioController>());
    helpValue = (sharedPrefs.getInt(Constants.helpKey) ?? 3).obs;
    levelId.value = (sharedPrefs.getInt(Constants.levelKey) ?? 1);
    groupId.value = sharedPrefs.getInt(Constants.groupKey) ?? 1;
  }

  bool _dragHorizontalLeft = false,
      _dragHorizontalRight = false,
      _dragVerticalDown = false,
      _dragVerticalUp = false,
      _dragDiagonalDownRight = false,
      _dragDiagonalUpRight = false,
      _dragDiagonalDownLeft = false,
      _dragDiagonalUpLeft = false,
      _tapped = false;

  void init(int level, int group) async {
    trackTaped.clear();
    wordsResult.clear();
    if (levels == null) {
      GameSettings gameSettings = await _gameDBController.getSettings();
      levels = gameSettings.levels;
    }
    if (level != -1 && group != -1) {
      currentLevelId.value = level;
      currentGroupId.value = group;
    }

    wordsList = levels![(currentLevelId.value +
                Constants.levelPerGroup * (currentGroupId.value - 1)) -
            1]
        .result;

    WSSettings ws = WSSettings(
      width: 6,
      preferOverlap: false,
      height: 6,
      orientations: List.from([
        WSOrientation.horizontal,
        WSOrientation.vertical,
        WSOrientation.diagonal,
      ]),
    );
    WordSearch wordSearch = WordSearch();
    newPuzzle = wordSearch.newPuzzle(wordsList, ws).obs;
    levelInitialized.value = true;
  }

  void detectTapedItem(PointerEvent event, GlobalKey key) {
    final RenderBox box =
        key.currentContext!.findAncestorRenderObjectOfType<RenderBox>()!;
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        final target = hit.target;
        if (target is CardItem &&
            ((_dragHorizontalLeft == false &&
                    _dragHorizontalRight == false &&
                    _dragVerticalDown == false &&
                    _dragVerticalUp == false &&
                    _dragDiagonalDownRight == false &&
                    _dragDiagonalUpRight == false &&
                    _dragDiagonalDownLeft == false &&
                    _dragDiagonalUpLeft == false) ||
                (trackTaped.isNotEmpty &&
                    !trackTaped[trackTaped.length - 1].contains(target)))) {
          if (!_tapped) {
            _tapped = true;
            trackTaped.add([target]);
            trackTaped.refresh();
          } else {
            _dragHorizontal(target);
            _dragVertical(target);
            _dragDiagonal(target);
          }
        }
      }
    }
  }

  void _dragHorizontal(target) {
    if (_dragVerticalDown == false &&
        _dragVerticalUp == false &&
        _dragHorizontalLeft == false &&
        _dragDiagonalDownRight == false &&
        _dragDiagonalUpRight == false &&
        _dragDiagonalDownLeft == false &&
        _dragDiagonalUpLeft == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index + 1) {
          _addTapedTarget(target);
          _dragHorizontalRight = true;
        }
      }
    }

    if (_dragVerticalDown == false &&
        _dragVerticalUp == false &&
        _dragHorizontalRight == false &&
        _dragDiagonalDownRight == false &&
        _dragDiagonalUpRight == false &&
        _dragDiagonalDownLeft == false &&
        _dragDiagonalUpLeft == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index - 1) {
          _addTapedTarget(target);
          _dragHorizontalLeft = true;
        }
      }
    }
  }

  void _dragVertical(target) {
    if (_dragVerticalDown == false &&
        _dragHorizontalLeft == false &&
        _dragHorizontalRight == false &&
        _dragDiagonalDownRight == false &&
        _dragDiagonalUpRight == false &&
        _dragDiagonalDownLeft == false &&
        _dragDiagonalUpLeft == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index - 6) {
          _addTapedTarget(target);
          _dragVerticalUp = true;
        }
      }
    }

    if (_dragVerticalUp == false &&
        _dragHorizontalLeft == false &&
        _dragHorizontalRight == false &&
        _dragDiagonalDownRight == false &&
        _dragDiagonalUpRight == false &&
        _dragDiagonalDownLeft == false &&
        _dragDiagonalUpLeft == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index + 6) {
          _addTapedTarget(target);
          _dragVerticalDown = true;
        }
      }
    }
  }

  void _dragDiagonal(target) {
    if (_dragDiagonalDownRight == false &&
        _dragDiagonalDownLeft == false &&
        _dragDiagonalUpLeft == false &&
        _dragHorizontalLeft == false &&
        _dragHorizontalRight == false &&
        _dragVerticalDown == false &&
        _dragVerticalUp == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index - 7) {
          _addTapedTarget(target);
          _dragDiagonalUpRight = true;
        }
      }
    }

    if (_dragDiagonalUpRight == false &&
        _dragDiagonalDownLeft == false &&
        _dragDiagonalUpLeft == false &&
        _dragHorizontalLeft == false &&
        _dragHorizontalRight == false &&
        _dragVerticalDown == false &&
        _dragVerticalUp == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index + 7) {
          _addTapedTarget(target);
          _dragDiagonalDownRight = true;
        }
      }
    }

    if (_dragDiagonalUpRight == false &&
        _dragDiagonalDownRight == false &&
        _dragDiagonalUpLeft == false &&
        _dragHorizontalLeft == false &&
        _dragHorizontalRight == false &&
        _dragVerticalDown == false &&
        _dragVerticalUp == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index + 5) {
          _addTapedTarget(target);
          _dragDiagonalDownLeft = true;
        }
      }
    }

    if (_dragDiagonalUpRight == false &&
        _dragDiagonalDownRight == false &&
        _dragDiagonalDownLeft == false &&
        _dragHorizontalLeft == false &&
        _dragHorizontalRight == false &&
        _dragVerticalDown == false &&
        _dragVerticalUp == false) {
      for (int i = 0;
          trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
          i++) {
        if (trackTaped[trackTaped.length - 1][i].index == target.index - 5) {
          _addTapedTarget(target);
          _dragDiagonalUpLeft = true;
        }
      }
    }
  }

  void _addTapedTarget(CardItem target) {
    if (trackTaped.isNotEmpty) {
      trackTaped[trackTaped.length - 1].add(target);
      trackTaped.refresh();
    }
  }

  void clearTapedSelection(PointerEvent event) {
    String result = "";
    for (int i = 0;
        trackTaped.isNotEmpty && i < trackTaped[trackTaped.length - 1].length;
        i++) {
      result += trackTaped[trackTaped.length - 1][i].value;
    }
    if (wordsList.contains(result)) {
      _audioController.playWordCompletedAudio();
      if (!wordsResult.contains(result)) {
        wordsResult.add(result);
        wordsResult.refresh();
      }
      if (trackTaped.length >= wordsList.length &&
          wordsList.length == wordsResult.length) {
        _refreshLevelCompleted();
      }
    } else {
      if (trackTaped.isNotEmpty) {
        trackTaped.removeLast();
        _audioController.playWordWrongAudio();
      }
    }

    _dragHorizontalLeft = false;
    _dragHorizontalRight = false;
    _dragVerticalDown = false;
    _dragVerticalUp = false;
    _dragDiagonalDownRight = false;
    _dragDiagonalUpRight = false;
    _dragDiagonalDownLeft = false;
    _dragDiagonalUpLeft = false;
    _tapped = false;
  }

  List<int> getTapedIndexList() {
    List<int> items = [];
    for (var i = 0; i < trackTaped.length; i++) {
      final List<CardItem> row = trackTaped[i];
      for (var j = 0; j < row.length; j++) {
        items.add(row[j].index);
      }
    }
    return items;
  }

  void _updateHelpValue() {
    int newValue = (sharedPrefs.getInt(Constants.helpKey) ?? 3) - 1;
    helpValue.value = newValue;
    sharedPrefs.putInt(Constants.helpKey, newValue);
  }

  void applyGameHelp() {
    for (var item in wordsList) {
      if (!wordsResult.contains(item)) {
        _audioController.playWordCompletedAudio();
        wordsResult.add(item);
        wordsResult.refresh();
        break;
      }
    }
    _updateHelpValue();
  }

  void _refreshLevelCompleted() {
    _audioController.playLevelCompletedAudio();
    if (currentGroupId.value == Constants.totalGroups) {
      if (currentLevelId.value < Constants.levelPerGroup) {
        if (levelCompleted.value == true) {
          levelCompleted.refresh();
        } else {
          levelCompleted.value = true;
        }
      } else {
        if (allLevelCompleted.value == true) {
          allLevelCompleted.refresh();
        } else {
          allLevelCompleted.value = true;
        }
      }
    } else {
      if (currentLevelId.value <= Constants.levelPerGroup) {
        if (levelCompleted.value == true) {
          levelCompleted.refresh();
        } else {
          levelCompleted.value = true;
        }
      }
    }
  }

  void updateLevel() {
    if (currentLevelId.value < Constants.totalLevels) {
      int tempLevelId = currentLevelId.value + 1 ;
      int savedLevel = sharedPrefs.getInt(Constants.levelKey) ?? 1;
      if (tempLevelId > savedLevel) {
        sharedPrefs.putInt(Constants.levelKey, tempLevelId);
        int savedGroup = sharedPrefs.getInt(Constants.groupKey) ?? 1;
        if (tempLevelId > Constants.levelPerGroup) {
          sharedPrefs.putInt(Constants.levelKey, 1);
          currentLevelId.value = 1;
          int newGroupId = savedGroup + 1;
          sharedPrefs.putInt(Constants.groupKey, newGroupId);
          groupId.value = newGroupId;
          if (groupId <= Constants.totalGroups) {
            currentGroupId.value = newGroupId;
          }
        }else{
          currentLevelId.value++;
        }
        levelId.value = currentLevelId.value;
      }
    }
  }
}
