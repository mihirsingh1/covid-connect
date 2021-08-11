import 'package:covid_connect/data/local_storage.dart';
import 'package:covid_connect/data/models/covid_item.dart';
import 'package:covid_connect/data/models/item_request_response.dart';
import 'package:covid_connect/data/models/login_response.dart';
import 'package:covid_connect/data/network_service.dart';

class Repository {
  List<CovidItem> covidItems = [];
  List<CovidItem> allItems = [];

  final NetworkService service;
  final LocalStorage localStorage;

  Repository(this.service, this.localStorage);

  Future<LoginResponse> login(String username, String password) async {
    final loginResponse = await service.login(username, password);

    if (loginResponse.isSuccess) {
      onLoggedIn(loginResponse.authToken, username);
    }

    return loginResponse;
  }

  Future<LoginResponse> signup(String username, String password) async {
    final loginResponse = await service.signup(username, password);
    if (loginResponse.isSuccess) {
      onLoggedIn(loginResponse.authToken, username);
    }
    return loginResponse;
  }

  void onLoggedIn(String sessionToken, String username) {
    localStorage.storeUser(sessionToken, username);
  }

  void fetchUserItems(String token) async {
    final rawList = await service.fetchUserItems(token);
    final list = rawList
        .map(
          (e) => CovidItem(
              itemName: e["item"],
              desc: e["desc"],
              contact: e["contact"],
              city: e["city"],
              id: e["_id"]),
        )
        .toList();
    covidItems = list;
  }

  Future<ItemRequestReponse> makeItemRequest(String itemName,
      String description, String contact, String cityName, String token) async {
    final responseMap = await service.makeItemRequest(
        itemName, description, contact, cityName, token);

    late ItemRequestReponse itemRequest;
    if (responseMap["isSuccess"]) {
      final covidItem = CovidItem(
        city: responseMap["item"]["city"],
        contact: responseMap["item"]["contact"],
        itemName: responseMap["item"]["item"],
        desc: responseMap["item"]["desc"],
        id: responseMap["item"]["_id"],
      );

      covidItems.add(covidItem);
      allItems.insert(0, covidItem);

      itemRequest = ItemRequestReponse(true, "");
    } else {
      itemRequest = ItemRequestReponse(false, responseMap["message"]);
    }

    return itemRequest;
  }

  Future<bool> deleteItem(String id, String token) async {
    final isDeleted = await service.deleteItem(id, token);

    if (isDeleted) {
      covidItems = covidItems.where((element) => element.id != id).toList();
      allItems = allItems.where((element) => element.id != id).toList();
    }

    return isDeleted;
  }

  Future<void> fetchAllItems() async {
    final rawList = await service.fetchAllItems();
    final list = rawList
        .map(
          (e) => CovidItem(
              itemName: e["item"],
              desc: e["desc"],
              contact: e["contact"],
              city: e["city"],
              id: e["_id"]),
        )
        .toList();
    allItems = list;
  }
}
