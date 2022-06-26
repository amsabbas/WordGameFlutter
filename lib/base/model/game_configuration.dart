import 'package:word_game/base/model/game_settings.dart';

class GameConfiguration {
  GameSettings settings;

  GameConfiguration(this.settings);

  factory GameConfiguration.fromJson(Map<String, dynamic> json) =>
      GameConfiguration(GameSettings.fromJson(json['settings'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['settings'] = settings.toJson();
    return data;
  }
}
