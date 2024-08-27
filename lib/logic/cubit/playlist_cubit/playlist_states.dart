import 'package:musix/data/model/songs_model.dart';

abstract class PlaylistStates {
  final List<SongModel> playlist;
  PlaylistStates(this.playlist);
}

class PlaylistInitialState extends PlaylistStates {
  PlaylistInitialState() : super([]);
}

class PlaylistLoadingState extends PlaylistStates {
  PlaylistLoadingState(super.playlist);
}

class PlaylistLoadedState extends PlaylistStates {
  PlaylistLoadedState(super.playlist);
}

class PlaylistErrorState extends PlaylistStates {
  final String playlistmessage;
  PlaylistErrorState(this.playlistmessage, super.playlist);
}
