import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  double sliderValue = 0;

  void setUrl(String url) {
    audioPlayer.setUrl(url);
    progressBar();
    play();
  }

  void play() async {
    await audioPlayer.play();
    notifyListeners();
  }

  void pause() async {
    await audioPlayer.pause();
    notifyListeners();
  }

  void stop() async {
    await audioPlayer.stop();
    notifyListeners();
  }

  void playPause() {
    if (audioPlayer.playing) {
      pause();
    } else {
      play();
    }
  }

  void seek(double value) {
    audioPlayer.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  // void seekBar(double e) {
  //   sliderValue = e;
  //   notifyListeners();
  // }

  void progressBar() {
    audioPlayer.durationStream.listen((d) {
      duration = d ?? Duration.zero;
      notifyListeners();
    });
    audioPlayer.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });
  }
}
