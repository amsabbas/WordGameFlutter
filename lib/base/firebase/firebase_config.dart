import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfig {
  RemoteConfig? _remoteConfig;
  FirebaseRemoteConfig();

  initFirebase({int cacheDuration = 0}) async {
    try {
      await Firebase.initializeApp();
      _remoteConfig = RemoteConfig.instance;
      _remoteConfig?.setConfigSettings(RemoteConfigSettings(
        minimumFetchInterval: Duration(hours: cacheDuration),
        fetchTimeout: const Duration(seconds: 10),
      ));
      //this delay is to solve an issue in which the Firebase isn't initialized when running the app for the first time
      await Future.delayed(const Duration(milliseconds: 500));
      await _remoteConfig?.fetchAndActivate();
    } catch (_) {
    }
  }

  Future<Map<String, dynamic>?> getConfig({required String configKey}) async {
    try {
      String? data = _remoteConfig?.getString(configKey).toString();

      if (data != null) {
        final config = json.decode(data);
        return config;
      }
    } catch (_) {
    }
    return null;
  }
}
