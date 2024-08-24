import 'package:musix/data/model/user_model.dart';

abstract class UserStates {}

class InitialState extends UserStates {}

class LoadingState extends UserStates {}

class LoggedInState extends UserStates {
  final UserModel userModel;
  LoggedInState({required this.userModel});
}

class LogOutState extends UserStates {}

class ErrorState extends UserStates {
  final String errormsg;
  ErrorState({required this.errormsg});
}
