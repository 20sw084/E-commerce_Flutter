// Wrapper will display either authenticated side, or authentication side based on User model's existence
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tri_karo_2/models/user_model.dart';
import 'package:tri_karo_2/utils/app_shared_preferences.dart';
import 'package:tri_karo_2/views/authenticate/authenticate.dart';
import 'package:tri_karo_2/views/home_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // load user from shared preferences
  getUserFromSF(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("user") != null) {
      user.fromJson(await AppSharedPreference.readUser("user"));
      user.toJson();
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    getUserFromSF(user);

    if(user.email != null) {
      return const HomeScreen();
    }
    else {
      return const Authenticate();
    }
  }
}
