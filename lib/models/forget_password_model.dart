import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassword extends ChangeNotifier {
  String email = "";
  String authToken = "";

  inputEmail(String inputEmail) {
    email = inputEmail;
    notifyListeners();
  }

  setToken(String token) {
    authToken = token;
  }
  /*addStringToSF(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }*/
}