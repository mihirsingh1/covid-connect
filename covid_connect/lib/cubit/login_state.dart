part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginResult extends LoginState {
  final LoginResponse loginResponse;

  LoginResult(this.loginResponse);
}
