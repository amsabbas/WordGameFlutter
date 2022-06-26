import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:word_game/base/utils/constants.dart';
import 'package:word_game/base/widget/empty_app_bar.dart';
import 'package:word_game/game/controller/game_controller.dart';

import '../../base/injection/general_injection.dart';
import '../../base/language/language.dart';
import '../widget/level_item_widget.dart';

class LevelsScreen extends StatefulWidget {
  final String title;
  final int groupId;

  const LevelsScreen(this.title, this.groupId, {Key? key}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
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
            gridWidget,
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
              widget.title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20, color: AppColors.whiteColor, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget get gridWidget {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.9,
              crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (_, index) {
            late IconData iconData;
            late Color iconColor;
            return Obx(
              () {
                if (_gameController.groupId.value > widget.groupId) {
                  iconData = Icons.done;
                  iconColor = AppColors.greenLight;
                } else if (_gameController.groupId.value == widget.groupId) {
                  if ((_gameController.levelId.value) == index + 1) {
                    iconData = Icons.play_arrow;
                    iconColor = AppColors.blueLightColor;
                  } else if ((_gameController.levelId.value) > index + 1) {
                    iconData = Icons.done;
                    iconColor = AppColors.greenLight;
                  } else {
                    iconColor = AppColors.yellowColor;
                    iconData = Icons.lock;
                  }
                }
                return LevelItemWidget(
                    title: MessageKeys.levelTitleKey.tr + " ${index + 1}",
                    iconColor: iconColor,
                    groupId: widget.groupId,
                    levelId: index + 1,
                    icon: iconData);
              },
            );
          },
          itemCount: Constants.levelPerGroup,
        ),
      ),
    );
  }
}
