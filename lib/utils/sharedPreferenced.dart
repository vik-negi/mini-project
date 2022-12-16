import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> sharedPrefs() async {
  return await SharedPreferences.getInstance();
}

class SharedPrefs {
  static Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await sharedPrefs();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await sharedPrefs();
    String? value = prefs.getString(key);
    return value;
  }

  static Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await sharedPrefs();
    prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await sharedPrefs();
    bool? value = prefs.getBool(key);
    return value;
  }
}
