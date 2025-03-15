// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';

class BackgroundMusic {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> play() async {
    try {
      await _player.setSource(AssetSource('sounds/bg.mp3'));
      _player.setReleaseMode(ReleaseMode.loop); // Loop the music
    } catch (e) {
      //print("Error playing music: $e");
    }
  }

  static Future<void> pause() async {
    await _player.pause();
  }

  static Future<void> resume() async {
    await _player.resume();
  }

  static Future<void> stop() async {
    await _player.stop();
  }
}
