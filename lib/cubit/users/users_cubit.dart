
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mool_task/data/model/user_response.dart';
import 'package:mool_task/data/repository/auth_repo.dart';
import 'package:mool_task/methods/custom_flushbar.dart';

import '../../data/model/signup_user.dart';
import '../../data/repository/users_repo.dart';



part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> { UsersCubit() : super(UsersLoading());

  final UsersRepo _usersRepo = UsersRepo();

  void fetchAllUsers(BuildContext context) async {
    emit(UsersLoading());
    try {
      final usersResp = await _usersRepo.fetchAllUsers();
      if (usersResp!=null) {
        emit(UsersSuccess(allUsers: usersResp));
      } else {
        emit(UsersFailed(error: "Users Failed"));
      }

    } catch (e) {
      debugPrint(e.toString());
      showCustomFlushbar("Error!", e.toString(), context);
      emit(UsersFailed(error: e.toString()));
    }
  }

}