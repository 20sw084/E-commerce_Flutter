import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier{
  int? id;
  String? nickName;
  String? firstName;
  String? lastName;
  String? name;
  String? address;
  String? dob;
  String? phone;
  String? email;
  String? authToken;
  int?  code;

  fromJson(Map<String,dynamic> json) {
    authToken = json["token"];
    Map<String,dynamic> user = json["user"];
    name = user["name"];
    id = user["id"];
    firstName = user["first_name"];
    lastName = user["last_name"];
    phone = user["phone"];
    email = user["email"];
    code = user["code"];
    notifyListeners();
  }

  Map<String,dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "first_name" : firstName,
    "last_name" : lastName,
    "phone" : phone,
    "email" : email,
    "code" : code,
    "address" : address,
    "token" : authToken,
  };

  updateProfile({
    required String newName,
    required String inputNickname,
    required String inputAddress,
    required String inputDob,
}) {
    name = newName;
    nickName = inputNickname;
    address = inputAddress;
    dob = inputDob;
    notifyListeners();
   }

  removeUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    authToken = "";
    //Map<String,dynamic> user = json["user"];
    name = null;
    id = null;
    firstName = null;
    lastName = null;
    phone = null;
    email = null;
    code = null;
    notifyListeners();
  }
  /*"email_verified_at": "2022-11-12T00:00:00.000000Z",
  "created_at": "2022-11-12T15:36:16.000000Z",
  "updated_at": "2022-11-12T15:36:16.000000Z",
  "deleted_at": null*/
}