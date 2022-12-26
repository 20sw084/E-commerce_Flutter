import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quickvilla/models/user_model.dart';
import 'package:quickvilla/screens/home_screen.dart';
import 'package:quickvilla/screens/login_screen.dart';
import 'package:quickvilla/utils/app_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  getUserFromSF(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("user") != null) {
      user.fromJson(
        // the value from key "user" is returned from shared pref and is passed as
        // json to user models' fromJson
          await AppSharedPreference.readUser("user"));
      user.toJson();
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user != null) {
      getUserFromSF(user);
    }

    if (user.email != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
