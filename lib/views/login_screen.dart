import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/user_model.dart';
import 'package:tri_karo_2/services/login.dart';
import 'package:tri_karo_2/utils/app_shared_preferences.dart';
import 'package:tri_karo_2/views/forgot_password_screen.dart';
import 'package:tri_karo_2/views/home_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/primary_button.dart';
import '../widgets/textfield_decoration.dart';

class LoginScreen extends StatefulWidget {

  final void Function() toggleView;
  const LoginScreen({required this.toggleView, Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool isPasswordObscure = true;

  String _email = "";
  String _password = "";
  bool _isLoading = false;

  void toggleChecked() => setState(() => isChecked = !isChecked);

  void togglePassword() =>
      setState(() => isPasswordObscure = !isPasswordObscure);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return LoaderOverlay(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: white,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: transparent,
              /*leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(EvaIcons.arrowBack, color: black, size: 32)),*/
              systemOverlayStyle: SystemUiOverlayStyle.dark),
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // const SizedBox(height: 32),
                    Text('Login To Your Account',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                            height: 1.35)),
                    const SizedBox(height: 56),
                    TextField(
                        onChanged: (val) => _email = val,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldDecoration(
                            label: 'Email Address',
                            prefixIcon: Icons.email_rounded)),
                    const SizedBox(height: 24),
                    TextField(
                        onChanged: (val) => _password = val,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isPasswordObscure,
                        decoration: textFieldDecoration(
                            label: 'Password',
                            prefixIcon: EvaIcons.lock,
                            suffixIcon: IconButton(
                                onPressed: () => togglePassword(),
                                icon: Icon(
                                    isPasswordObscure
                                        ? EvaIcons.eye
                                        : EvaIcons.eyeOff2,
                                    color: grey_2)))),
                    const SizedBox(height: 16),
                    GestureDetector(
                        onTap: () => toggleChecked(),
                        child: Row(children: [
                          isChecked
                              ? Icon(EvaIcons.checkmarkSquare2,
                                  color: red_1, size: 24)
                              : Icon(EvaIcons.square, color: grey_2, size: 24),
                          const SizedBox(width: 16),
                          Text('Remember Me',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: grey_1))
                        ])),
                    const SizedBox(height: 24),
                    PrimaryButton(
                        ontap: () async {
                            _isLoading = true;
                              context.loaderOverlay.show();
                          log(_isLoading.toString());
                          dynamic jsonResponse =
                              await login(email: _email, password: _password).whenComplete(() => _isLoading = false);
                          if(!_isLoading) {
                            context.loaderOverlay.hide();
                          };
                          if (jsonResponse["user"] != null) {
                            await AppSharedPreference.alreadyLoggedIn('logged_in', true);
                            await AppSharedPreference.saveUser("user", jsonResponse["user"]);
                            user.fromJson(jsonResponse);
                            user.toJson();
                            log(jsonResponse.toString());
                            if(!mounted) return;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } else {
                            if(jsonResponse["login"] != null && jsonResponse["login"].length >0) {
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                /*duration: const Duration(
                                    milliseconds: 3000),*/
                                behavior:
                                SnackBarBehavior.floating,
                                backgroundColor:
                                Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Invalid Credentials!',
                                  message:
                                  jsonResponse["login"][0]
                                      .toString(),
                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType:
                                  ContentType.failure,
                                ),
                              );
                              if(!mounted) return;
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(jsonResponse["login"][0]
                                      .toString())));
                              log(jsonResponse.toString());*/
                            }
                            else if(jsonResponse["email"] != null && jsonResponse["email"].length >0) {
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                /*duration: const Duration(
                                    milliseconds: 3000),*/
                                behavior:
                                SnackBarBehavior.floating,
                                backgroundColor:
                                Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Invalid Credentials!',
                                  message:
                                  jsonResponse["email"][0]
                                      .toString(),
                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType:
                                  ContentType.failure,
                                ),
                              );
                              if(!mounted) return;
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(jsonResponse["email"][0]
                                      .toString())));*/
                            }
                          }
                        },
                        text: 'Login'),
                    const SizedBox(height: 16),
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen())),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text('Forgot Password?',
                                style: GoogleFonts.poppins(
                                    color: red_1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)))),
                    const Spacer(),
                    Row(children: [
                      Expanded(child: Container(color: grey_3, height: 1)),
                      const SizedBox(width: 16),
                      Text('Or continue with',
                          style:
                              GoogleFonts.poppins(color: grey_1, fontSize: 12)),
                      const SizedBox(width: 16),
                      Expanded(child: Container(color: grey_3, height: 1))
                    ]),
                    const SizedBox(height: 32),
                    Row(children: [
                      socialButton('instagram', () {}),
                      const SizedBox(width: 16),
                      socialButton('google', () {}),
                      const SizedBox(width: 16),
                      socialButton('facebook', () {})
                    ]),
                    const SizedBox(height: 24),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Don\'t have an account?  ',
                          style:
                              GoogleFonts.poppins(color: grey_2, fontSize: 14)),
                      GestureDetector(
                          onTap: () => widget.toggleView(),/*Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen())),*/
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('Sign up',
                                  style: GoogleFonts.poppins(
                                      color: red_1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)))),
                    ]),
                    const SizedBox(height: 4),
                  ])))),
    );
  }

  Expanded socialButton(String platform, VoidCallback onTap) => Expanded(
      child: GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const HomeScreen())),
          child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: grey_3),
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(16),
              child: Image.asset('$imagePath/${platform}_logo.png'))));
}
