import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musix/logic/provider/audio_provider.dart';
import 'package:musix/services/util.dart';
import 'package:provider/provider.dart';

class Songpage extends StatelessWidget {
  const Songpage({super.key});

  String formatTime(Duration duration) {
    final String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final String formattedTime = "${duration.inMinutes}:${twoDigitSeconds}";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<AudioProvider>(
      builder: (context, v, child) {
        return Scaffold(
          backgroundColor: hexToColor(v.hexcode),
          appBar: AppBar(
            backgroundColor: hexToColor(v.hexcode),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: Colors.teal,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: NetworkImage(
                        v.thumnail_url,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(v.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white)),
                Text(v.artist,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)),
                Slider(
                  min: 0,
                  max: v.duration.inSeconds.toDouble(),
                  value: v.isCompleted ? 0 : v.position.inSeconds.toDouble(),
                  onChangeEnd: (value) {
                    v.seek(value);
                  },
                  onChanged: (value) {
                    // Optionally handle slider change
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Current position
                        Text(
                          formatTime(
                              v.isCompleted ? Duration.zero : v.position),
                          style: const TextStyle(color: Colors.white),
                        ),
                        // Total duration
                        Text(formatTime(v.duration),
                            style: const TextStyle(color: Colors.white)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Handle back navigation
                        },
                      ),
                      SizedBox(
                        height: 66,
                        width: 66,
                        child: IconButton(
                          icon: v.isBuffering
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : v.isCompleted
                                  ? const Icon(Icons.play_arrow,
                                      color: Colors.white)
                                  : Icon(
                                      color: Colors.white,
                                      v.isPlaying
                                          ? CupertinoIcons.pause
                                          : CupertinoIcons.play,
                                    ),
                          iconSize: 50,
                          onPressed: () {
                            v.isCompleted ? v.play() : v.playPause();
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        onPressed: () {
                          // Handle forward navigation
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
