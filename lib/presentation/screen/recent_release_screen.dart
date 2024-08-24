import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/logic/cubit/song_cubit/song_cubit.dart';
import 'package:musix/logic/cubit/song_cubit/song_states.dart';
import 'package:musix/logic/provider/audio_provider.dart';
import 'package:musix/presentation/screen/songpage.dart';
import 'package:provider/provider.dart';

class RecentReleaseScreen extends StatelessWidget {
  const RecentReleaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Release',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<SongCubit, SongStates>(builder: (context, state) {
        if (state is LoadingState && state.songs.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState && state.songs.isEmpty) {
          return Center(
            child: Text(state.msg),
          );
        }
        return ListView.builder(
          itemCount: state.songs.length,
          itemBuilder: (BuildContext context, int index) {
            final data = state.songs[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Songpage(
                            title: data.title,
                            artist: data.artist,
                            url: data.song_url)));
                Provider.of<AudioProvider>(context, listen: false)
                    .setUrl(data.song_url);
              },
              title: Text(data.title),
            );
          },
        );
      }),
    );
  }
}
