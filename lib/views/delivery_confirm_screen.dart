import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tri_karo_2/views/home_screen.dart';
import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/primary_button.dart';

class DeliveryConfirmScreen extends StatelessWidget {
  const DeliveryConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      appBar: const CustomAppBar(title: 'Delivery', isSearchVisible: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PrimaryButton(ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())), text: 'Confirm')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Weight', style: GoogleFonts.poppins(color: black, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            TextField(
                decoration: InputDecoration(
                    prefixIconColor: grey_2,
                    suffixIconColor: grey_2,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    border: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: grey_2), borderRadius: BorderRadius.circular(8.0)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: red_1), borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    hintStyle: GoogleFonts.poppins(fontSize: 14, color: grey_2.withOpacity(0.75)),
                    floatingLabelStyle: TextStyle(color: grey_1),
                    hintText: '0-100 Kgs',
                    fillColor: grey_5)),
            const SizedBox(height: 24),
            Text('Message', style: GoogleFonts.poppins(color: black, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            TextField(
                minLines: 5,
                maxLines: 5,
                decoration: InputDecoration(
                    prefixIconColor: grey_2,
                    suffixIconColor: grey_2,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    border: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: grey_2), borderRadius: BorderRadius.circular(8.0)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
                    errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: red_1), borderRadius: BorderRadius.circular(8.0)),
                    filled: true,
                    hintStyle: GoogleFonts.poppins(fontSize: 14, color: grey_2.withOpacity(0.75)),
                    floatingLabelStyle: TextStyle(color: grey_1),
                    hintText: '0-100 Kgs',
                    fillColor: grey_5)),
            const SizedBox(height: 24),
            Row(children: [
              Icon(EvaIcons.checkmarkSquare2Outline, color: red_1),
              const SizedBox(width: 12),
              Text('Weight', style: GoogleFonts.poppins(color: black, fontWeight: FontWeight.w500))
            ])
          ])));
}
