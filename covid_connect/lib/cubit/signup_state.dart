part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupResult extends SignupState {
  final LoginResponse loginResponse;

  SignupResult(this.loginResponse);
}
