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
        title: const Text(
          'Recent Releases',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SongCubit, SongStates>(
        builder: (context, state) {
          if (state is LoadingState && state.songs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.msg,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Optionally, trigger a refresh or retry
                      context.read<SongCubit>().refresh;
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state.songs.isEmpty) {
            return const Center(
              child: Text('No recent releases available'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.songs.length,
            itemBuilder: (BuildContext context, int index) {
              final data = state.songs[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  onTap: () {
                    Provider.of<AudioProvider>(context, listen: false)
                        .setSource(data);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Songpage(),
                      ),
                    );
                    Provider.of<AudioProvider>(context, listen: false)
                        .setSource(data);
                  },
                  title: Text(
                    data.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data.artist),
                  trailing: const Icon(Icons.play_arrow),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
