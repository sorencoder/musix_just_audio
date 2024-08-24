import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musix/logic/cubit/made_for_you/made_for_you_cubit.dart';
import 'package:musix/logic/cubit/made_for_you/made_for_you_states.dart';
import 'package:musix/logic/provider/audio_provider.dart';
import 'package:musix/presentation/screen/songpage.dart';
import 'package:provider/provider.dart';

class Fetch extends StatelessWidget {
  const Fetch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Made For You'),
      ),
      body: BlocBuilder<MadeForYouCubit, MadeForYouStates>(
          builder: (context, state) {
        if (state is MFALoadingState && state.madeForYou.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MFAErrorState && state.madeForYou.isEmpty) {
          return Center(
            child: Text(state.message),
          );
        }
        return ListView.builder(
          itemCount: state.madeForYou.length,
          itemBuilder: (BuildContext context, int index) {
            final data = state.madeForYou[index];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // repo.fetchSongs();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
