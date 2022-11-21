import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/forget_password_model.dart';
import 'package:tri_karo_2/models/home_model.dart';
import 'package:tri_karo_2/models/user_model.dart';
import 'package:tri_karo_2/utils/app_shared_preferences.dart';
import 'package:tri_karo_2/views/onboarding_screen.dart';
import 'package:tri_karo_2/views/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool loggedIn = await AppSharedPreference.readLoggedIn("logged_in") ?? false;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => User()),
      ChangeNotifierProvider(create: (context) => ForgetPassword()),
      Provider(create: (context) => HomeData()),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TRI KARO 2',
        theme: ThemeData(primarySwatch: Colors.red),
        home:
            loggedIn ? const Wrapper() : const OnboardingScreen()),
  ));
}