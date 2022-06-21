part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginClickEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginClickEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class LogoutClickEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
