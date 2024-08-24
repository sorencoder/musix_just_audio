import 'package:flutter/material.dart';
import 'package:musix/logic/provider/audio_provider.dart';
import 'package:provider/provider.dart';

class Songpage extends StatelessWidget {
  final String title;
  final String artist;
  final String url;

  const Songpage(
      {super.key,
      required this.title,
      required this.artist,
      required this.url});

  String formartTime(Duration duration) {
    String twodigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twodigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.teal),
            ),
            Text(title),
            Text(artist),
            Consumer<AudioProvider>(
              builder: (context, v, child) {
                return Slider(
                    min: 0,
                    max: v.duration.inSeconds.toDouble(),
                    value: v.isCompleted ? 0 : v.position.inSeconds.toDouble(),
                    onChangeEnd: (value) {
                      Provider.of<AudioProvider>(context, listen: false)
                          .seek(value);
                    },
                    onChanged: (e) {
                      // Provider.of<AudioProvider>(context).seekBar(e);
                    });
              },
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Consumer<AudioProvider>(
                  builder: (context, v, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //current position
                        v.isCompleted
                            ? Text(formartTime(Duration.zero))
                            : Text(formartTime(v.position)),
                        //total duration
                        Text(formartTime(v.duration))
                      ],
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  Consumer<AudioProvider>(
                    builder: (context, v, child) {
                      return SizedBox(
                        height: 66,
                        width: 66,
                        child: IconButton(
                          icon: v.isBuffering
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : v.isCompleted
                                  ? const Icon(Icons.play_arrow)
                                  : v.isPlaying
                                      ? const Icon(Icons.pause)
                                      : const Icon(Icons.play_arrow),
                          iconSize: 50,
                          onPressed: () {
                            v.isCompleted
                                ? Provider.of<AudioProvider>(context,
                                        listen: false)
                                    .playAgain(url)
                                : Provider.of<AudioProvider>(context,
                                        listen: false)
                                    .playPause();
                          },
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
