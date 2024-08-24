import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/made_for_you_repo.dart';
import 'package:musix/data/model/made_for_you.dart';
import 'package:musix/logic/cubit/made_for_you/made_for_you_states.dart';

class MadeForYouCubit extends Cubit<MadeForYouStates> {
  MadeForYouCubit() : super(MFAInitialState()) {
    _initialize();
  }

  final _madeForYou = MadeForYouRepo();
  void _initialize() async {
    emit(MFALoadingState(state.madeForYou));
    try {
      List<MadeForYou> songs = await _madeForYou.fetchSongs();
      emit(MFALoadedState(songs));
    } catch (e) {
      emit(MFAErrorState(e.toString(), state.madeForYou));
    }
  }
}
