part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UsersSuccess extends UsersState {
  final List<UserResponse> allUsers;

  UsersSuccess({required this.allUsers});
}

class UsersFailed extends UsersState {
  final String error;

  UsersFailed({required this.error});
}



