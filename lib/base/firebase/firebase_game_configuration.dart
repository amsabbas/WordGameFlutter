import '../controller/game_db_controller.dart';

import '../model/game_configuration.dart';
import 'firebase_config.dart';
import 'package:get/get.dart';

class FirebaseGameConfiguration {
  FirebaseRemoteConfig remoteConfig;
  GameDBController gameDBController;

  FirebaseGameConfiguration(this.remoteConfig, this.gameDBController) {
    gameDBController = Get.put(gameDBController);
  }

  Future<GameConfiguration?> getGameConfiguration() async {
    Map<String, dynamic>? json;
    const gameSettings = "game_settings";
    try {
      json = await remoteConfig.getConfig(configKey: gameSettings);
      if (json != null) {
        GameConfiguration settingsModel = GameConfiguration.fromJson(json);
        gameDBController.insert(settingsModel.settings);
        return settingsModel;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
