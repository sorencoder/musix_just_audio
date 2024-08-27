import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/playlist_repo.dart';
import 'package:musix/data/model/songs_model.dart';
import 'package:musix/logic/cubit/playlist_cubit/playlist_states.dart';

class PlaylistCubit extends Cubit<PlaylistStates> {
  final _playlist = PlaylistRepo();
  PlaylistCubit() : super(PlaylistInitialState()) {
    _initialize();
  }

  void _initialize() async {
    try {
      List<SongModel> data =
          await _playlist.fetchSongs('BQQ4LpCTPDUlayCVhhYc3UTwMkU2');
      emit(PlaylistLoadedState(data));
    } catch (e) {
      emit(PlaylistErrorState(e.toString(), state.playlist));
    }
  }
}
