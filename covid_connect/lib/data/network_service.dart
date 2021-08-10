import 'dart:convert';

import 'package:covid_connect/constants/strings.dart';
import 'package:covid_connect/data/models/covid_item.dart';
import 'package:covid_connect/data/models/item_request_response.dart';
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
        return LoginResponse(
            username: responseMap["username"],
            isSuccess: true,
            authToken: responseMap["token"]);
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
        return LoginResponse(
            username: responseMap["username"],
            isSuccess: true,
            authToken: responseMap["token"]);
      }

      return LoginResponse(isSuccess: false, error: responseMap["error"]);
    } catch (err) {
      return LoginResponse(isSuccess: false, error: "Something went wrong");
    }
  }

  Future<Map> makeItemRequest(String itemName, String description,
      String contact, String cityName, String token) async {
    try {
      final body = {
        "item": itemName,
        "desc": description,
        "contact": contact,
        "city": cityName
      };

      jsonContentHeader["auth-token"] = token;

      final response = await post(
        Uri.parse(serverAddress + "itemRequest"),
        headers: jsonContentHeader,
        body: jsonEncode(body),
      );

      final responseMap = jsonDecode(response.body);
      return responseMap;
    } catch (err) {
      return Map();
    }
  }

  Future<List<dynamic>> fetchUserItems(String token) async {
    try {
      final response = await get(Uri.parse(serverAddress + "items"),
          headers: {"auth-token": token});
      final jsonList = jsonDecode(response.body) as List;
      return jsonList;
    } catch (err) {
      return [];
    }
  }

  Future<bool> deleteItem(String id, String token) async {
    try {
      final response = await delete(Uri.parse(serverAddress + "deleteItem/$id"),
          headers: {"auth-token": token});

      return jsonDecode(response.body)["isSuccess"];
    } catch (err) {
      return true;
    }
  }

  Future<List<dynamic>> fetchAllItems() async {
    try {
      final response = await get(Uri.parse(serverAddress + "allItems"));
      final jsonList = jsonDecode(response.body) as List;
      return jsonList;
    } catch (err) {
      return [];
    }
  }
}
