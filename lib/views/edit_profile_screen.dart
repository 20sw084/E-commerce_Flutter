import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/user_model.dart';
import 'package:tri_karo_2/services/update_profile.dart';
import 'package:tri_karo_2/views/home_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/primary_button.dart';
import '../widgets/textfield_decoration.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String name = "";
  String nickName = "";
  String address = "";
  String dob = "";

  bool isUserImageEmpty = true;

  toggleUserImage() => setState(() => isUserImageEmpty = !isUserImageEmpty);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
            title: const Text('Update Profile'),
            systemOverlayStyle: SystemUiOverlayStyle.dark),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 32),
                child: Column(children: [
                  Stack(alignment: Alignment.bottomRight, children: [
                    CircleAvatar(
                        radius: 64,
                        backgroundColor: grey_5,
                        backgroundImage: AssetImage(isUserImageEmpty
                            ? '$imagePath/empty_profile_image.png'
                            : '$imagePath/sample_user_image.png')),
                    GestureDetector(
                        onTap: () => toggleUserImage(),
                        child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                                color: red_1,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: red_1.withOpacity(0.35),
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                      spreadRadius: -2)
                                ]),
                            child: Icon(EvaIcons.editOutline, color: white)))
                  ]),
                  const SizedBox(height: 48),
                  TextFormField(
                      onChanged: (val) => name = val,
                      keyboardType: TextInputType.name,
                      decoration: textfieldStyle.copyWith(
                          prefixIcon:
                          const Icon(EvaIcons.personOutline, size: 18),
                          labelText: 'Full Name')),
                  const SizedBox(height: 20),
                  TextFormField(
                      onChanged: (val) => nickName = val,
                      keyboardType: TextInputType.name,
                      decoration: textfieldStyle.copyWith(
                          prefixIcon:
                          const Icon(EvaIcons.personOutline, size: 18),
                          labelText: 'Nick Name')),
                  const SizedBox(height: 20),
                  TextFormField(
                      onChanged: (val) => dob = val,
                      keyboardType: TextInputType.datetime,
                      decoration: textfieldStyle.copyWith(
                          prefixIcon:
                          const Icon(EvaIcons.calendarOutline, size: 18),
                          labelText: 'Date of Birth')),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: textfieldStyle.copyWith(
                          prefixIcon:
                          const Icon(EvaIcons.emailOutline, size: 18),
                          labelText: 'Email Address')),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: textfieldStyle.copyWith(
                          prefixIcon:
                          const Icon(EvaIcons.phoneOutline, size: 18),
                          labelText: 'Phone Number')),
                  const SizedBox(height: 20),
                  TextFormField(
                      onChanged: (val) => address = val,
                      keyboardType: TextInputType.streetAddress,
                      decoration: textfieldStyle.copyWith(
                          prefixIcon:
                          const Icon(EvaIcons.homeOutline, size: 18),
                          labelText: 'Residential Address')),
                  const SizedBox(height: 32),
                  PrimaryButton(
                      ontap: () async {
                        dynamic response = await updateProfile(
                          token: user.authToken!,
                            name: name,
                            nickName: nickName,
                            address: address,
                            dob: dob);
                        log(response.toString());
                        if(response["status"] != null && response["status"] == 200) {
                          log(response["status"].toString());
                          user.updateProfile(
                              newName: name,
                              inputNickname: nickName,
                              inputAddress: address,
                              inputDob: dob);
                          if(!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }
                        else {
                          log(response.toString());
                        }
                      },
                      text: 'Continue')
                ]))));
  }
}
