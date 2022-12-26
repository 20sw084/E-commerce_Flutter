import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickvilla/models/attribute_model.dart';
import 'package:quickvilla/models/user_model.dart';
import 'package:quickvilla/models/variations_model.dart';
import 'package:quickvilla/screens/splash_screen.dart';
import 'package:quickvilla/utils/app_shared_preferences.dart';
import 'package:quickvilla/utils/constants.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globals.token = await AppSharedPreference.readToken("token") ?? "";
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark,
  ));
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => User()),
          ChangeNotifierProvider(create: (context) => Attribute()),
          ChangeNotifierProvider(create: (context) => Variations()),
        ],
        child: MaterialApp(
            title: 'Quick Villa',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: MaterialColor(
                    const Color.fromRGBO(255, 0, 0, 1).value,
                    const <int, Color>{
                      50: Color.fromRGBO(255, 0, 0, 0.1),
                      100: Color.fromRGBO(255, 0, 0, 0.2),
                      200: Color.fromRGBO(255, 0, 0, 0.3),
                      300: Color.fromRGBO(255, 0, 0, 0.4),
                      400: Color.fromRGBO(255, 0, 0, 0.5),
                      500: Color.fromRGBO(255, 0, 0, 0.6),
                      600: Color.fromRGBO(255, 0, 0, 0.7),
                      700: Color.fromRGBO(255, 0, 0, 0.8),
                      800: Color.fromRGBO(255, 0, 0, 0.9),
                      900: Color.fromRGBO(255, 0, 0, 1)
                    }),
                primaryColor: red,
                fontFamily: 'Poppins'),
            home: const SplashScreen()),
      );
}
