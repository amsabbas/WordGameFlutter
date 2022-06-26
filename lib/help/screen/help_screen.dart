import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:word_game/base/widget/empty_app_bar.dart';
import 'package:word_game/help/controller/help_controller.dart';

import '../../base/controller/audio_controller.dart';
import '../../base/injection/general_injection.dart';
import '../../base/language/language.dart';
import '../../base/utils/ad_helper.dart';
import '../../base/utils/custom_snack_bar.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  late final HelpController _helpController;
  late final AudioController _audioController;

  @override
  void initState() {
    super.initState();
    _helpController = Get.put(getIt<HelpController>());
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
          height: double.infinity,
          child: Column(
            children: [
              appBar,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [helpButton1Widget, helpButton2Widget],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get appBar {
    return Container(
      color: AppColors.yellowColor,
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
              MessageKeys.helpButtonTitle.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20, color: AppColors.whiteColor, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget get helpButton1Widget {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 65,
        width: double.infinity,
        child: Card(
          color: AppColors.greenLight,
          child: TextButton(
            onPressed: () async {
              _audioController.playButtonClickAudio();
              _showInterstitialAd();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.ad_units,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        MessageKeys.helpTitle.tr,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 20,
                            color: AppColors.whiteColor,
                            height: 1.5),
                      ),
                    ],
                  ),
                  Text(
                    "+1",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 20, color: AppColors.whiteColor, height: 1.2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get helpButton2Widget {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 65,
        width: double.infinity,
        child: Card(
          color: AppColors.blueLightColor,
          child: TextButton(
            onPressed: () async {
              _audioController.playButtonClickAudio();
              _showRewardAd();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.ad_units,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        MessageKeys.helpTitle.tr,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 20,
                            color: AppColors.whiteColor,
                            height: 1.5),
                      ),
                    ],
                  ),
                  Text(
                    "+2",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 20, color: AppColors.whiteColor, height: 1.2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.show();
            _helpController.saveHelpValue(1);
            _showHelpValueAddedSnackBar();
          },
          onAdFailedToLoad: (LoadAdError error) {
            CustomSnackBar.showFailureSnackBar(
                title: MessageKeys.error.tr,
                message: MessageKeys.failHelpMessageKey.tr);
          },
        ));
  }

  void _showRewardAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedInterstitialUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              _helpController.saveHelpValue(2);
              _showHelpValueAddedSnackBar();
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            CustomSnackBar.showFailureSnackBar(
                title: MessageKeys.error.tr,
                message: MessageKeys.failHelpMessageKey.tr);
          },
        ));
  }

  void _showHelpValueAddedSnackBar() {
    CustomSnackBar.showSuccessSnackBar(
        MessageKeys.attention.tr, MessageKeys.helpValueAddedMessage.tr);
  }
}
