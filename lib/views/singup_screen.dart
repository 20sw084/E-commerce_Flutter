import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/user_model.dart';
import 'package:tri_karo_2/services/register.dart';
import 'package:tri_karo_2/utils/app_shared_preferences.dart';
import 'package:tri_karo_2/views/edit_profile_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/textfield_decoration.dart';
import '../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  final void Function() toggleView;
  const SignupScreen({required this.toggleView, Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPassword1Obscure = true;
  bool isPassword2Obscure = true;

  void togglePassword1() =>
      setState(() => isPassword1Obscure = !isPassword1Obscure);

  void togglePassword2() =>
      setState(() => isPassword2Obscure = !isPassword2Obscure);

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String emailAddress = "";
  String password = "";
  String confirmPassword = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return LoaderOverlay(
      child: Scaffold(
          //
          //resizeToAvoidBottomInset: false,
          backgroundColor: white,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: transparent,
              /*leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(EvaIcons.arrowBack, color: black, size: 32)),*/
              systemOverlayStyle: SystemUiOverlayStyle.dark),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                child: IntrinsicHeight(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    const SizedBox(height: 20),
                    Text('Create your Account',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                            height: 1.35)),
                    const SizedBox(height: 20),
                    TextFormField(
                        onChanged: (val) => firstName = val,
                        keyboardType: TextInputType.text,
                        decoration: textFieldDecoration(
                            label: 'First Name', prefixIcon: Icons.person)),
                    const SizedBox(height: 24),
                    TextFormField(
                        onChanged: (val) => lastName = val,
                        keyboardType: TextInputType.text,
                        decoration: textFieldDecoration(
                            label: 'Last Name', prefixIcon: Icons.person)),
                    const SizedBox(height: 24),
                    TextFormField(
                        onChanged: (val) => phoneNumber = val,
                        keyboardType: TextInputType.number,
                        decoration: textFieldDecoration(
                            label: 'Phone number',
                            prefixIcon: Icons.contact_phone)),
                    const SizedBox(height: 24),
                    TextFormField(
                        onChanged: (val) => emailAddress = val,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldDecoration(
                            label: 'Email Address',
                            prefixIcon: Icons.email_rounded)),
                    const SizedBox(height: 24),
                    TextFormField(
                        onChanged: (val) => password = val,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isPassword1Obscure,
                        decoration: textFieldDecoration(
                            label: 'Password',
                            prefixIcon: EvaIcons.lock,
                            suffixIcon: IconButton(
                                onPressed: () => togglePassword1(),
                                icon: Icon(
                                    isPassword1Obscure
                                        ? EvaIcons.eye
                                        : EvaIcons.eyeOff2,
                                    color: grey_2)))),
                    const SizedBox(height: 24),
                    TextFormField(
                        onChanged: (val) => confirmPassword = val,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isPassword2Obscure,
                        decoration: textFieldDecoration(
                            label: 'Confirm Password',
                            prefixIcon: EvaIcons.lock,
                            suffixIcon: IconButton(
                                onPressed: () => togglePassword2(),
                                icon: Icon(
                                    isPassword2Obscure
                                        ? EvaIcons.eye
                                        : EvaIcons.eyeOff2,
                                    color: grey_2)))),
                    const SizedBox(height: 24),
                    PrimaryButton(
                        ontap: () async {
                          _isLoading = true;
                          context.loaderOverlay.show();
                          dynamic response = await register(
                              firstName: firstName,
                              lastName: lastName,
                              phoneNumber: phoneNumber,
                              email: emailAddress,
                              password: password,
                              confirmPass: confirmPassword).whenComplete(() => _isLoading = false);
                          if(!_isLoading) context.loaderOverlay.hide();
                          if (response["user"] != null) {
                            await AppSharedPreference.alreadyLoggedIn('logged_in', true);
                            await AppSharedPreference.saveUser("user", response);
                            user.fromJson(response);
                            user.toJson();
                            if (!mounted) return;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen()));
                          } else {
                            if (response["phone"] != null &&
                                response["phone"].length > 0) {
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
                                  'The phone number you entered is already in use',
                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType:
                                  ContentType.failure,
                                ),
                              );
                              if(!mounted) return;
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content:
                              //             Text("The phone is already in use")));
                            }
                            else if (response["confirm_password"] != null &&
                                response["confirm_password"].length > 0) {
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
                                  "The passwords don't match",
                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType:
                                  ContentType.failure,
                                ),
                              );
                              if(!mounted) return;
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content:
                              //             Text("The phone is already in use")));
                            }
                            else if (response["email"] != null &&
                                response["email"].length > 0) {
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
                                  'The email you entered is already in use',
                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType:
                                  ContentType.failure,
                                ),
                              );
                              if(!mounted) return;
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content:
                              //             Text("The email is already in use")));
                            } else {
                              log("Something went wrong with the server, Make sure you are connected to the internet");
                              if (!mounted) return;
                              //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong with the server, Make sure you are connected to the internet")));
                            }
                          }
                        },
                        text: 'Sign up'),
                    const SizedBox(height: 26),
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          socialButton('instagram', () {}),
                          const SizedBox(width: 16),
                          socialButton('google', () {}),
                          const SizedBox(width: 16),
                          socialButton('facebook', () {})
                        ]),
                    const SizedBox(height: 24),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Already have an account?  ',
                          style:
                              GoogleFonts.poppins(color: grey_2, fontSize: 14)),
                      GestureDetector(
                          onTap: () => widget.toggleView(),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('Login',
                                  style: GoogleFonts.poppins(
                                      color: red_1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)))),
                    ]),
                    const SizedBox(height: 16),
                  ]),
                ),
              ),
            ),
          )),
    );
  }

  socialButton(String platform, VoidCallback onTap) => GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: white,
              border: Border.all(color: grey_3),
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16),
          child: Image.asset('$imagePath/${platform}_logo.png')));
}
