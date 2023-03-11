
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mool_task/data/repository/auth_repo.dart';
import 'package:mool_task/methods/custom_flushbar.dart';

import '../../data/model/signup_user.dart';



part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoading());

  final AuthRepo _authRepo = AuthRepo();

  void checkAlreadySignedIn() async {
    try {
      emit(AuthLoading());

      Future.delayed(const Duration(milliseconds: 1000), () {
        emit(UnAuthorizedState());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(UnAuthorizedState());
    }
  }

  void signUp(SignupUser user, BuildContext context) async {

    emit(AuthLoading());
    try {
      final signUpResp = await _authRepo.signup(user);
      if (signUpResp.message == "User created") {
        showCustomFlushbar("Success", signUpResp.message.toString(), context);
        emit(SignInState());
      } else {
        emit(SignUpFailed(error: signUpResp.message??"Sign Up Failed"));
      }

    } catch (e) {
      debugPrint(e.toString());
      showCustomFlushbar("Error!", e.toString(), context);
      emit(SignUpFailed(error: e.toString()));
    }
  }


  void login(String username, String pwd, BuildContext context) async {
    emit(AuthLoading());
    try {
      final loginResp = await _authRepo.login(username, pwd);
      if (loginResp.accessToken!=null) {
        emit(SignInSuccess(jwtToken: loginResp.accessToken!));
      } else {
        emit(SignInFailed(error: "Login Failed"));
      }

    } catch (e) {
      debugPrint(e.toString());
      showCustomFlushbar("Error!", e.toString(), context);
      emit(SignInFailed(error: e.toString()));
    }
  }

}