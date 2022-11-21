import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/forget_password_model.dart';
import 'package:tri_karo_2/services/forget_password.dart';
import 'package:tri_karo_2/views/otp_screen.dart';
import '../utils/colors.dart';
import '../widgets/textfield_decoration.dart';
import '../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final forgetPassProvider = Provider.of<ForgetPassword>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: transparent,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(EvaIcons.arrowBack, color: black, size: 32)),
            systemOverlayStyle: SystemUiOverlayStyle.dark),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 32),
                  Text('Forgotten Your Password?',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          height: 1.35)),
                  const SizedBox(height: 24),
                  Text(
                    'Enter your email address, and we\'ll send you a link to get back into your account.',
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 72),
                  TextField(
                      onChanged: (val) => forgetPassProvider.inputEmail(val),
                      keyboardType: TextInputType.emailAddress,
                      decoration: textFieldDecoration(
                          label: 'Email Address',
                          prefixIcon: Icons.email_rounded)),
                  const SizedBox(height: 24),
                  PrimaryButton(
                      ontap: () async {
                        dynamic response = await forgetPassword(email: forgetPassProvider.email);
                        if(response["status"] == 200) {
                          forgetPassProvider.setToken(response["update_token"]);
                          if(!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OtpScreen()));
                        }},
                      text: 'Send'),
                ]))));
  }
}
