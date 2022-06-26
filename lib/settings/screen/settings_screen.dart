import 'package:flutter/material.dart';
import 'package:word_game/base/controller/audio_controller.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:word_game/base/utils/custom_dialog.dart';
import 'package:word_game/base/widget/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:word_game/settings/controller/settings_controller.dart';
import '../../base/injection/general_injection.dart';
import '../../base/language/language.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../base/utils/constants.dart';
import '../../base/widget/button_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsController _settingsController;
  late final AudioController _audioController;

  @override
  void initState() {
    super.initState();
    _settingsController = Get.put(getIt<SettingsController>());
    _audioController = Get.put(getIt<AudioController>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: AppColors.defaultColor,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              _appBar,
              const SizedBox(
                height: 20,
              ),
              _soundWidget,
              const SizedBox(
                height: 5,
              ),
              _shareButtonWidget,
              const SizedBox(
                height: 5,
              ),
              _resetButtonWidget
            ],
          ),
        ),
      ),
    );
  }

  Widget get _appBar {
    return Container(
      color: AppColors.tealColor,
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                _audioController.playButtonClickAudio();
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
              MessageKeys.settingsButtonTitle.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20, color: AppColors.whiteColor, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _soundWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          MessageKeys.settingsSoundTitle.tr,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 20, color: AppColors.whiteColor, height: 1.5),
        ),
        Obx(() => Switch(
            activeColor: AppColors.yellowColor,
            inactiveTrackColor: AppColors.darkGrayColor,
            value: _settingsController.musicState.value,
            onChanged: (value) {
              _settingsController
                  .saveMusicState(!_settingsController.isMusicEnabled());
              _audioController.playButtonClickAudio();
            })),
      ],
    );
  }

  Widget get _shareButtonWidget {
    return ButtonWidget(
        buttonText: MessageKeys.settingsShareTitle.tr,
        buttonColor: AppColors.tealColor,
        iconData: Icons.share,
        buttonAction: () {
          _share();
        });
  }

  void _share() {
    FlutterShare.share(
        title: MessageKeys.settingsShareTitle.tr,
        text: MessageKeys.downloadNowTitleKey.tr,
        linkUrl: 'https://play.google.com/store/apps/details?id=' +
            Constants.androidPackageName,
        chooserTitle: MessageKeys.settingsShareTitle.tr);
  }

  Widget get _resetButtonWidget {
    return ButtonWidget(
        buttonText: MessageKeys.settingsResetTitle.tr,
        buttonColor: AppColors.tealColor,
        iconData: Icons.refresh,
        buttonAction: () {
          CustomDialog.showConfirmationDialog(
              context,
              MessageKeys.attention.tr,
              MessageKeys.settingsConfirmationResetMessage.tr,
              MessageKeys.yes.tr, () {
            _settingsController.resetGame();
            CustomDialog.showMessageDialog(
                context,
                MessageKeys.attention.tr,
                MessageKeys.settingsResetSuccessMessage.tr,
                MessageKeys.dismiss.tr, () {
            });
          }, MessageKeys.no.tr, () {
          });
        });
  }
}
