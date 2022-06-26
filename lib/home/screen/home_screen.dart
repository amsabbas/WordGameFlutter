import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:word_game/base/injection/general_injection.dart';
import 'package:word_game/base/language/language.dart';
import 'package:word_game/base/style/colors.dart';
import 'package:word_game/base/utils/constants.dart';
import 'package:word_game/base/widget/empty_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:word_game/base/widget/gradient_vertical_widget.dart';
import 'package:word_game/help/screen/help_screen.dart';

import '../../base/firebase/firebase_game_configuration.dart';
import '../../base/utils/ad_helper.dart';
import '../../base/utils/asset_resource.dart';
import '../../base/widget/button_widget.dart';
import '../../base/widget/gradient_horizontal_widget.dart';
import '../../groups/screen/groups_screen.dart';
import '../../settings/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    getIt<FirebaseGameConfiguration>().getGameConfiguration();

    _showBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: AppColors.blueColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    dividerHorizontalWidget,
                    logoWidget,
                    dividerHorizontalWidget,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          startGameWidget,
                          settingsWidget,
                          helpWidget,
                          moreAppsWidget,
                        ],
                      ),
                    ),
                    if (_isLoaded)
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: AdWidget(ad: _bannerAd),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget get dividerHorizontalWidget {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
      child: SizedBox(
        height: 1,
        width: double.infinity,
        child: GradientHorizontalWidget(colors: [
          AppColors.greenLight,
          AppColors.tealColor,
          AppColors.yellowColor,
          AppColors.redColor
        ]),
      ),
    );
  }

  Widget get dividerVerticalWidget {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: 1,
        height: 160,
        child: GradientVerticalWidget(colors: [
          AppColors.greenLight,
          AppColors.tealColor,
          AppColors.yellowColor,
          AppColors.redColor
        ]),
      ),
    );
  }

  Widget get logoWidget {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Row(
        children: [
          dividerVerticalWidget,
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                child: Image.asset(AssetResource.homeLogoImagePath),
              ),
            ),
          ),
          dividerVerticalWidget,
        ],
      ),
    );
  }

  Widget get startGameWidget {
    return ButtonWidget(
        buttonText: MessageKeys.startGameButtonTitle.tr,
        buttonColor: AppColors.greenLight,
        iconData: Icons.play_arrow,
        buttonAction: () async {
          Get.to(() => const GroupsScreen(), transition: Transition.zoom);
        });
  }

  Widget get settingsWidget {
    return ButtonWidget(
        buttonText: MessageKeys.settingsButtonTitle.tr,
        buttonColor: AppColors.tealColor,
        iconData: Icons.settings,
        buttonAction: () async {
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
                          child: const SettingsScreen());
                    },
                  )),
              barrierDismissible: false,
            ),
          );
        });
  }

  Widget get helpWidget {
    return ButtonWidget(
        buttonText: MessageKeys.helpButtonTitle.tr,
        buttonColor: AppColors.yellowColor,
        iconData: Icons.help,
        buttonAction: () async {
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
                          height: height / 2.5,
                          child: const HelpScreen());
                    },
                  )),
              barrierDismissible: false,
            ),
          );
        });
  }

  Widget get moreAppsWidget {
    return ButtonWidget(
        buttonText: MessageKeys.moreAppsButtonTitle.tr,
        buttonColor: AppColors.redColor,
        iconData: Icons.apps,
        buttonAction: () async {
          const url = 'https://play.google.com/store/apps/developer?id=' +
              Constants.androidAccountName;
          if (await canLaunch(url)) {
            await launch(url);
          }
        });
  }

  Future<void> _showBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    return _bannerAd.load();
  }
}
