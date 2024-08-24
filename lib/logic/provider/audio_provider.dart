import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  final _audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String msg = '';

  AudioPlayer get audioPlayer => _audioPlayer;
  bool get isPlaying => _audioPlayer.playing;
  bool get isBuffering =>
      _audioPlayer.processingState == ProcessingState.buffering;
  bool get isCompleted =>
      _audioPlayer.processingState == ProcessingState.completed;
  void setUrl(String url) {
    try {
      _audioPlayer.setUrl(url);
      progressBar();
      playerStateStream();
      play();
    } catch (e) {
      msg = e.toString();
    }
  }

  void play() async {
    try {
      await _audioPlayer.play();
      notifyListeners();
    } catch (e) {
      msg = e.toString();
      notifyListeners();
    }
  }

  void pause() async {
    try {
      await _audioPlayer.pause();
      notifyListeners();
    } catch (e) {
      msg = e.toString();
      notifyListeners();
    }
  }

  void playPause() {
    if (isPlaying) {
      pause();
    } else {
      play();
    }
  }

  void playAgain(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      notifyListeners();
    } catch (e) {
      msg = e.toString();
      notifyListeners();
    }
  }

  void seek(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  // void seekBar(double e) {
  //   sliderValue = e;
  //   notifyListeners();
  // }

  void progressBar() {
    _audioPlayer.durationStream.listen((d) {
      duration = d ?? Duration.zero;
      notifyListeners();
    });
    _audioPlayer.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });
  }

  void playerStateStream() {
    _audioPlayer.playerStateStream.listen((state) {
      notifyListeners();
    });
  }

//   // Define the playlist
//   final playlist = ConcatenatingAudioSource(
//     // Start loading next item just before reaching it
//     useLazyPreparation: true,
//     // Customise the shuffle algorithm
//     shuffleOrder: DefaultShuffleOrder(),
//     // Specify the playlist items
//     children: [
//       AudioSource.uri(Uri.parse('https://example.com/track1.mp3')),
//       AudioSource.uri(Uri.parse('https://example.com/track2.mp3')),
//       AudioSource.uri(Uri.parse('https://example.com/track3.mp3')),
//     ],
//   );

// // Load and play the playlist
// // await player.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
// // await player.seekToNext();                     // Skip to the next item
// // await player.seekToPrevious();                 // Skip to the previous item
// // await player.seek(Duration.zero, index: 2);    // Skip to the start of track3.mp3
// // await player.setLoopMode(LoopMode.all);        // Set playlist to loop (off|all|one)
// // await player.setShuffleModeEnabled(true);      // Shuffle playlist order (true|false)

// // Update the playlist
// // await playlist.add(newChild1);
// // await playlist.insert(3, newChild2);
// // await playlist.removeAt(3);
}
