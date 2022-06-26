import 'package:get_it/get_it.dart';
import 'package:word_game/help/controller/help_controller.dart';
import '../controller/game_db_controller.dart';
import 'package:word_game/game/controller/game_controller.dart';
import 'package:word_game/settings/controller/settings_controller.dart';

import '../controller/audio_controller.dart';
import '../firebase/firebase_config.dart';
import '../firebase/firebase_game_configuration.dart';
import '../utils/shared_preference.dart';

final getIt = GetIt.instance;

Future<void> initGeneralInjection() async {
  getIt.registerSingletonAsync<FirebaseRemoteConfig>(() async {
    final remoteConfig = FirebaseRemoteConfig();
    await remoteConfig.initFirebase();
    return remoteConfig;
  });

  getIt.registerSingletonAsync<SharedPrefs>(() async {
    final sharedPrefs = SharedPrefs();
    await sharedPrefs.init();
    return sharedPrefs;
  });

  getIt.registerFactory<GameDBController>(() => GameDBController());

  await GetIt.instance.isReady<FirebaseRemoteConfig>().then((_) async {
    getIt.registerFactory<FirebaseGameConfiguration>(() =>
        FirebaseGameConfiguration(
            getIt<FirebaseRemoteConfig>(), getIt<GameDBController>()));
  });

  await GetIt.instance.isReady<SharedPrefs>().then((_) async {
    getIt.registerFactory<HelpController>(
        () => HelpController(sharedPrefs: getIt<SharedPrefs>()));
    getIt.registerFactory<AudioController>(
        () => AudioController(sharedPrefs: getIt<SharedPrefs>()));
    getIt.registerFactory<GameController>(
        () => GameController(sharedPrefs: getIt<SharedPrefs>()));
    getIt.registerFactory<SettingsController>(
        () => SettingsController(sharedPrefs: getIt<SharedPrefs>()));
  });
}
