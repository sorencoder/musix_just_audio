import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/logic/cubit/usercubit/user_cubit.dart';
import 'package:musix/logic/cubit/usercubit/user_states.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;
  final UserCubit _userCubit;

  LoginProvider(this.context)
      : _userCubit = BlocProvider.of<UserCubit>(context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String errormsg = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription = _userCubit.stream.listen((userState) {
      if (userState is LoadingState) {
        isLoading = true;
        errormsg = '';
      } else if (userState is ErrorState) {
        isLoading = false;
        errormsg = userState.errormsg;
      } else {
        isLoading = false;
        errormsg = '';
      }
      notifyListeners();
    });
  }

  void signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errormsg = 'Email and password cannot be empty';
      notifyListeners();
      return;
    }

    _userCubit.signIn(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
