import 'package:covid_connect/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;

  LocalStorage(this.prefs);

  void storeUser(String sessionToken, String username) async {
    try {
      await prefs.setString(authTokenKey, sessionToken);
      await prefs.setString(usernameKey, username);
    } catch (err) {
      print(err);
    }
  }

  String getToken() {
    return prefs.getString(authTokenKey) ?? "";
  }

  String getUsername() {
    return prefs.getString(usernameKey) ?? "";
  }

  bool isUserLoggedIn() {
    return getToken() != "";
  }

  Future<bool> logoutUser() async {
    try {
      await prefs.setString(authTokenKey, "");
      await prefs.setString(usernameKey, "");

      return true;
    } catch (err) {
      return false;
    }
  }
}
