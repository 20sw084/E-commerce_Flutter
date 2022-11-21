import 'package:flutter/material.dart';
import 'package:tri_karo_2/utils/app_shared_preferences.dart';
import 'package:tri_karo_2/views/login_screen.dart';
import 'package:tri_karo_2/views/singup_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  bool notFirstTimeUser = false;

  checkAlreadyRegistered() async {
    notFirstTimeUser = await AppSharedPreference.readLoggedIn("logged_in") ?? false;
  }

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (notFirstTimeUser || showSignIn) {
      return LoginScreen(toggleView: toggleView);
    } else {
      return SignupScreen(toggleView: toggleView);
    }
  }
}
