import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:word_game/base/model/level.dart';
import 'dart:async';
import 'package:path/path.dart';
import '../model/game_settings.dart';

class GameDBController extends GetxController {
  late Database db;
  static const String tableName = "levels";
  static const String columnId = "Id";
  static const String columnResult = "result";
  static const String columnImageName = "image";

  Future<void> _open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "levels.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''create table $tableName ($columnId integer primary key autoincrement,
      $columnResult text not null, $columnImageName text not null)''');
    });
  }

  void insert(GameSettings settings) async {
    await _open();
    await db.delete(tableName);

    List<Level> levels = settings.levels;
    String result = "";
    String? imageName = "";

    for (var i = 0; i < levels.length; i++) {
      result = "";
      for (var j = 0; j < levels[i].result.length; j++) {
        if (j == levels[i].result.length - 1) {
          result += levels[i].result[j] ;
        } else {
          result += levels[i].result[j] + ";";
        }
      }
      imageName = levels[i].imageName;
      db.insert(tableName, {columnResult: result, columnImageName: imageName});
    }
  }

  Future<GameSettings> getSettings() async {
    await _open();
    List<Map> maps = await db.query(
      tableName,
      columns: [columnResult, columnImageName],
    );
    if (maps.first.isNotEmpty) {
      GameSettings gameSettings = GameSettings([]);
      List<Level> levels = [];
      for (var element in maps) {
        String imageName = "";
        List<String> result = [];
        element.forEach((key, value) {
          if (key == columnImageName) {
            imageName = value;
          } else if (key == columnResult) {
            result = value.split(';');
          }
        });
        levels.add(Level(result, imageName));
      }
      gameSettings.levels = levels;
      return gameSettings;
    }
    return GameSettings([]);
  }

  Future close() async => db.close();

  @override
  void dispose() {
    close();
    super.dispose();
  }
}
