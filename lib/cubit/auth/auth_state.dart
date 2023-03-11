part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class SignInState extends AuthState {}

class SignInSuccess extends AuthState {
  final String jwtToken;

  SignInSuccess({required this.jwtToken});
}

class UnAuthorizedState extends AuthState {}

class SignInFailed extends AuthState {
  final String error;

  SignInFailed({required this.error});
}

class SignUpFailed extends AuthState {
  final String error;

  SignUpFailed({required this.error});
}


