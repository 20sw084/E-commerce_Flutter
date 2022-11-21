import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {

  static alreadyLoggedIn(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static readLoggedIn(String key) async {
    final prefs = await SharedPreferences.getInstance();
    //json.decode to convert json string back to Json Object
    return prefs.getBool(key);
  }

  static saveUser(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static readUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    //json.decode to convert json string back to Json Object
    if(prefs.getString(key) != null) {
      return json.decode(prefs.getString(key)!);
    }
  }
}