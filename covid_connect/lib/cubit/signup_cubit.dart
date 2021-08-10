import 'package:bloc/bloc.dart';
import 'package:covid_connect/constants/functions.dart';
import 'package:covid_connect/data/models/login_response.dart';
import 'package:covid_connect/data/repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final Repository repository;
  SignupCubit(this.repository) : super(SignupInitial());

  void signup(String username, String password) async {
    final loginResponse = await repository.signup(username, password);
    emit(SignupResult(loginResponse));
  }
}
