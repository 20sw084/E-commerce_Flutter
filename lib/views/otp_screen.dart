import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/forget_password_model.dart';
import 'package:tri_karo_2/views/new_password_screen.dart';
import '../utils/colors.dart';
import '../widgets/primary_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider is called here to get email of the user requesting for password change.
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
            title: const Text('Enter OTP'),
            systemOverlayStyle: SystemUiOverlayStyle.dark),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        'Code has been sent to ${forgetPassProvider.email}',
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 72),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                digitTextField(context),
                                digitTextField(context),
                                digitTextField(context),
                                digitTextField(context),
                                digitTextField(context),
                                digitTextField(context),
                              ])),
                      const Spacer(),
                      PrimaryButton(
                          ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NewPasswordScreen())),
                          text: 'Verify'),
                      const SizedBox(height: 16)
                    ]))));
  }

  SizedBox digitTextField(BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.12,
      child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          cursorHeight: 30,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.w600, height: 2.4),
          decoration: InputDecoration(
              fillColor: grey_5,
              filled: true,
              hintText: '0',
              hintStyle: TextStyle(
                  fontSize: 24,
                  color: grey_3,
                  height: 2.5,
                  fontWeight: FontWeight.w600),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: grey_4),
                  borderRadius: BorderRadius.circular(8.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: grey_3.withOpacity(0.75)),
                  borderRadius: BorderRadius.circular(8.0)))));
}
