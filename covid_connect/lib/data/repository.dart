import 'package:covid_connect/data/local_storage.dart';
import 'package:covid_connect/data/models/login_response.dart';
import 'package:covid_connect/data/network_service.dart';

class Repository {
  final NetworkService service;
  final LocalStorage localStorage;

  Repository(this.service, this.localStorage);

  Future<LoginResponse> login(String username, String password) async {
    final loginResponse = await service.login(username, password);

    if (loginResponse.isSuccess) {
      onLoggedIn(loginResponse.authToken);
    }

    return loginResponse;
  }

  Future<LoginResponse> signup(String username, String password) async {
    final loginResponse = await service.signup(username, password);
    return loginResponse;
  }

  void onLoggedIn(String sessionToken) {
    localStorage.storeToken(sessionToken);
  }
}
