import 'dart:convert';

import 'package:covid_connect/constants/strings.dart';
import 'package:covid_connect/data/models/login_response.dart';
import 'package:http/http.dart';

class NetworkService {
  final Map<String, String> jsonContentHeader = {
    "Content-type": "application/json"
  };

  Future<LoginResponse> login(String username, String password) async {
    try {
      final body = {"username": username, "password": password};
      final response = await post(Uri.parse(serverAddress + "login"),
          headers: jsonContentHeader, body: jsonEncode(body));

      final responseMap = jsonDecode(response.body);
      if (responseMap["isLoginSuccess"]) {
        return LoginResponse(isSuccess: true, authToken: responseMap["token"]);
      }

      return LoginResponse(isSuccess: false, error: responseMap["error"]);
    } catch (err) {
      return LoginResponse(isSuccess: false, error: "Something went wrong");
    }
  }

  Future<LoginResponse> signup(String username, String password) async {
    try {
      final body = {"username": username, "password": password};
      final response = await post(Uri.parse(serverAddress + "signup"),
          headers: jsonContentHeader, body: jsonEncode(body));

      final responseMap = jsonDecode(response.body);
      if (responseMap["isLoginSuccess"]) {
        return LoginResponse(isSuccess: true, authToken: responseMap["token"]);
      }

      return LoginResponse(isSuccess: false, error: responseMap["error"]);
    } catch (err) {
      return LoginResponse(isSuccess: false, error: "Something went wrong");
    }
  }
}
