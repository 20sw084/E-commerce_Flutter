import 'dart:developer';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:quickvilla/models/user_model.dart';
import 'package:quickvilla/screens/home_screen.dart';
import 'package:quickvilla/services/login.dart';
import 'package:quickvilla/utils/app_shared_preferences.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_input_decoration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  bool isRememberSelected = false;
  bool isChecked = false;
  // bool isPasswordObscure = true;

  String _email = "";
  String _password = "";
  bool _isLoading = false;

  void toggleChecked() => setState(() => isChecked = !isChecked);

  // void togglePassword() =>
  //     setState(() => isPasswordObscure = !isPasswordObscure);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return LoaderOverlay(
      child: Scaffold(
          body: Center(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Login to your\nAccount',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 48,
                                    height: 1.4,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 40),
                            TextField(
                                onChanged: (val) => _email = val,
                                keyboardType: TextInputType.emailAddress,
                                decoration: textInputDecoration(
                                    label: 'Email', prefixIcon: Icons.mail)),
                            const SizedBox(height: 24),
                            TextField(
                                onChanged: (val) => _password = val,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: isPasswordVisible,
                                decoration: textInputDecoration(
                                    label: 'Password',
                                    prefixIcon: Icons.lock,
                                    suffixIcon: isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    suffixOnTap: () => setState(() =>
                                        isPasswordVisible =
                                            !isPasswordVisible))),
                            const SizedBox(height: 20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      value: isRememberSelected,
                                      onChanged: (value) => setState(
                                          () => isRememberSelected = value!),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                  const Text('Remember me',
                                      style: TextStyle(fontSize: 16))
                                ]),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              text: 'Sign in',
                              onTap: () async {
                                _isLoading = true;
                                context.loaderOverlay.show();
                                log(_isLoading.toString());
                                dynamic jsonResponse = await login(
                                        email: _email, password: _password)
                                    .whenComplete(() => _isLoading = false);
                                if (!_isLoading) {
                                  context.loaderOverlay.hide();
                                }
                                if (jsonResponse["user"] != null) {
                                  await AppSharedPreference.saveUserHasLoggedIn(
                                      'logged_in', true);

                                  await AppSharedPreference.saveUser(
                                      "user", jsonResponse);
                                  await AppSharedPreference.saveToken(
                                      "token", jsonResponse["token"]);
                                  globals.token = jsonResponse["token"];
                                  user.fromJson(jsonResponse);
                                  user.toJson();
                                  if (!mounted) return;
                                  /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()));*/
                                } else {
                                  if (jsonResponse["login"] != null &&
                                      jsonResponse["login"].length > 0) {
                                    log(jsonResponse["login"].toString());
                                    final snackBar = SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      /*duration: const Duration(
                                    milliseconds: 3000),*/
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Invalid Credentials!',
                                        message:
                                            jsonResponse["login"][0].toString(),

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.failure,
                                      ),
                                    );
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                    /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(jsonResponse["login"][0]
                                      .toString())));
                              log(jsonResponse.toString());*/
                                  } else if (jsonResponse["email"] != null &&
                                      jsonResponse["email"].length > 0) {
                                    final snackBar = SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      /*duration: const Duration(
                                    milliseconds: 3000),*/
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Invalid Credentials!',
                                        message:
                                            jsonResponse["email"][0].toString(),

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.failure,
                                      ),
                                    );
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                    /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(jsonResponse["email"][0]
                                      .toString())));*/
                                  }
                                }
                              },
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const HomeScreen()))
                            ),
                          ]))))),
    );
  }
}
