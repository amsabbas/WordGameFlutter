import 'package:get/get.dart';
import 'package:word_game/base/utils/constants.dart';

import '../../base/utils/shared_preference.dart';

class HelpController extends GetxController {
  SharedPrefs sharedPrefs;

  HelpController({required this.sharedPrefs});

  void saveHelpValue(int value) {
    sharedPrefs.putInt(Constants.helpKey,
        (sharedPrefs.getInt(Constants.helpKey) ?? 3) + value);
  }
}
