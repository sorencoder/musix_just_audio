import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/logic/cubit/usercubit/user_cubit.dart';
import 'package:musix/logic/cubit/usercubit/user_states.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context) {
    _listenToUserCubit();
  }
  bool isLoading = false;
  String errormsg = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  StreamSubscription? _userSubcribtion;
  void _listenToUserCubit() {
    _userSubcribtion =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is LoadingState) {
        isLoading = true;
        errormsg = '';
        notifyListeners();
      } else if (userState is ErrorState) {
        isLoading = false;
        errormsg = userState.errormsg;
        notifyListeners();
      } else {
        isLoading = false;
        errormsg = '';
        notifyListeners();
      }
    });
  }

  void signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<UserCubit>(context)
        .signIn(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubcribtion?.cancel();
    super.dispose();
  }
}
