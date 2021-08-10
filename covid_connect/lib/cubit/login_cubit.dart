import 'package:bloc/bloc.dart';
import 'package:covid_connect/constants/functions.dart';
import 'package:covid_connect/data/models/login_response.dart';
import 'package:covid_connect/data/repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository repository;
  LoginCubit(this.repository) : super(LoginInitial());

  void login(String username, String password) async {
    final loginResponse = await repository.login(username, password);
    emit(LoginResult(loginResponse));
  }
}
