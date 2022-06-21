part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  final LoginResponse loginResponse;

  const LoginSuccessState(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];
}

class LoginFailedState extends LoginState {
  final String message;

  const LoginFailedState(this.message);
  @override
  List<Object?> get props => [message];
}

class LoggedOutState extends LoginState {
  @override
  List<Object?> get props => [];
}
