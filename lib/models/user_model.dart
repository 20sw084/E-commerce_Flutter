import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  int? id;
  String? nickName;
  String? firstName;
  String? lastName;
  // profile
  String? phone;
  String? email;
  String? name;
  String? dob;
  String? address;
  String? avatar;
  String? authToken;
  Map<String, dynamic> mystore = {};

  fromJson(Map<String, dynamic> json) {
    name = json["user"]["name"];
    avatar = json["user"]["avatar"];
    id = json["user"]["id"];
    firstName = json["user"]["first_name"];
    lastName = json["user"]["last_name"];
    phone = json["user"]["phone"];
    email = json["user"]["email"];
    address = json["user"]["address"] ?? "";
    dob = json["user"]["dob"] ?? "";
    mystore = json["mystore"];
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "phone": phone,
        "address": address,
        "dob": dob,
        "email": email,
        "token": authToken,
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

  removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    prefs.remove("token");
    authToken = "";
    //Map<String,dynamic> user = json["user"];
    name = null;
    id = null;
    firstName = null;
    lastName = null;
    phone = null;
    email = null;
    notifyListeners();
  }
  /*"email_verified_at": "2022-11-12T00:00:00.000000Z",
  "created_at": "2022-11-12T15:36:16.000000Z",
  "updated_at": "2022-11-12T15:36:16.000000Z",
  "deleted_at": null*/
}
