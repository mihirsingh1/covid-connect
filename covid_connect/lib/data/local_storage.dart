import 'package:covid_connect/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;

  LocalStorage(this.prefs);

  void storeToken(String sessionToken) async {
    try {
      await prefs.setString(authTokenKey, sessionToken);
    } catch (err) {
      print(err);
    }
  }

  String getToken() {
    return prefs.getString(authTokenKey) ?? "";
  }

  bool isUserLoggedIn() {
    return getToken() != "";
  }
}
