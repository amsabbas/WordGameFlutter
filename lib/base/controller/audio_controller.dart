import 'package:audioplayers/audioplayers.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../utils/constants.dart';
import '../utils/shared_preference.dart';

class AudioController extends GetxController {
  AudioPlayer? _audioPlayer;

  late SharedPrefs sharedPrefs;

  AudioController({required this.sharedPrefs});

  void playButtonClickAudio() async {
    if (sharedPrefs.getBool(Constants.musicKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _audioPlayer = await audioCache.play("audio/button_click.wav");
    }
  }


  void playWordCompletedAudio() async {
    if (sharedPrefs.getBool(Constants.musicKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _audioPlayer = await audioCache.play("audio/word_completed.mp3");
    }
  }

  void playLevelCompletedAudio() async {
    if (sharedPrefs.getBool(Constants.musicKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _audioPlayer = await audioCache.play("audio/level_completed.wav");
    }
  }

  void playWordWrongAudio() async {
    if (sharedPrefs.getBool(Constants.musicKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _audioPlayer = await audioCache.play("audio/word_wrong.wav");
    }
  }

  void stopButtonClickAudio() {
    _audioPlayer?.stop();
  }

  @override
  void dispose() {
    stopButtonClickAudio();
    super.dispose();
  }
}
