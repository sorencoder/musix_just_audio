import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/user_repository.dart';
import 'package:musix/data/model/user_model.dart';
import 'package:musix/logic/cubit/usercubit/user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialState());
  final UserRepository _userRepository = UserRepository();

  void createAcount({required String email, required String password}) async {
    try {
      UserModel userModel =
          await _userRepository.createAccount(email, password);
      emit(LoggedInState(userModel: userModel));
    } catch (e) {
      emit(ErrorState(errormsg: e.toString()));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      try {
        UserModel userModel = await _userRepository.signIn(email, password);
        emit(LoggedInState(userModel: userModel));
      } catch (e) {
        emit(ErrorState(errormsg: e.toString()));
      }
    } catch (e) {
      emit(ErrorState(errormsg: e.toString()));
    }
  }
}
