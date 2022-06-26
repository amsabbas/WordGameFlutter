import 'package:get/get.dart';

import '../../base/utils/constants.dart';
import '../../base/utils/shared_preference.dart';

class SettingsController extends GetxController {
  SharedPrefs sharedPrefs;

  SettingsController({required this.sharedPrefs});

  RxBool musicState = true.obs;

  @override
  void onInit() {
    super.onInit();
    musicState = (sharedPrefs.getBool(Constants.musicKey) ?? true).obs;
  }

  void saveMusicState(bool audioEnabled) {
    musicState.value = audioEnabled;
    sharedPrefs.putBool(Constants.musicKey, audioEnabled);
  }

  bool isMusicEnabled() {
    return sharedPrefs.getBool(Constants.musicKey) ?? true;
  }

  void resetGame() {
    sharedPrefs.putInt(Constants.groupKey, 1);
    sharedPrefs.putInt(Constants.levelKey, 1);
    sharedPrefs.putInt(Constants.helpKey, 3);
  }

  @override
  void dispose() {
    musicState.close();
    super.dispose();
  }
}
