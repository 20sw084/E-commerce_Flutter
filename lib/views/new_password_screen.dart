import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/forget_password_model.dart';
import 'package:tri_karo_2/services/reset_password.dart';
import 'package:tri_karo_2/views/login_screen.dart';

import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/primary_button.dart';
import '../widgets/textfield_decoration.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool isPassword1Obscure = true;
  bool isPassword2Obscure = true;

  void togglePassword1() =>
      setState(() => isPassword1Obscure = !isPassword1Obscure);

  void togglePassword2() =>
      setState(() => isPassword2Obscure = !isPassword2Obscure);

  String _password = "";
  String _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    final forgetPassProvider = Provider.of<ForgetPassword>(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: transparent,
            foregroundColor: black,
            titleTextStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: black, fontSize: 22),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(EvaIcons.arrowBack, color: black, size: 28)),
            title: const Text('Update Password'),
            systemOverlayStyle: SystemUiOverlayStyle.dark),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(children: [
                  const Spacer(),
                  Image.asset('$imagePath/new_password.png', height: 200),
                  const Spacer(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'A code has been sent to ${forgetPassProvider.email}',
                          style: GoogleFonts.poppins(color: black))),
                  const SizedBox(height: 28),
                  TextField(
                      onChanged: (val) => _password = val,
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
                  TextField(
                      onChanged: (val) => _confirmPassword = val,
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
                       dynamic response = await resetPassword(
                            email: forgetPassProvider.email,
                            newPassword: _password,
                            confirmPassword: _confirmPassword);
                       if(!mounted) return;
                        Navigator.pop(context);
                      },
                      text: 'Save'),
                ]))));
  }
}
