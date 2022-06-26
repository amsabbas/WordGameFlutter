import 'level.dart';

class GameSettings {
  List<Level> levels;

  GameSettings(this.levels);

  factory GameSettings.fromJson(Map<String, dynamic> json) => GameSettings(
        (json['levels'] as List<dynamic>)
            .map((e) => Level.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['levels'] = levels.map((v) => v.toJson()).toList();
    return data;
  }
}
