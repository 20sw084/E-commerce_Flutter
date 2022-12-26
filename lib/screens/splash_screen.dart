import 'package:flutter/material.dart';
import 'package:quickvilla/screens/wrapper.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 2),
        // () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
        () => Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) => const Wrapper(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (_, Animation<double> animation, __, Widget child) => FadeTransition(opacity: animation, child: child))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Image.asset('$imagePath/logo.png', width: 300)));
}
