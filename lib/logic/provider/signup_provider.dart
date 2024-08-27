import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/logic/cubit/usercubit/user_cubit.dart';
import 'package:musix/logic/cubit/usercubit/user_states.dart';

class SignupProvider with ChangeNotifier {
  SignupProvider(this.context) {
    _listenToUserCubit();
  }

  final BuildContext context;
  bool isLoading = false;
  String errormsg = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
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

  void signUp() {
    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String cpassword =
          cpasswordController.text.trim(); // Include cpassword for validation
      String name = nameController.text.trim();

      if (password != cpassword) {
        errormsg = 'Passwords do not match';
        notifyListeners();
        return;
      }

      BlocProvider.of<UserCubit>(context)
          .createAccount(email: email, password: password, name: name);
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
