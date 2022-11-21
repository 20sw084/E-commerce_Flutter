import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tri_karo_2/views/delivery_confirm_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/primary_button.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: grey_2,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          foregroundColor: black,
          title: Text('Delivery', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500))),
      body: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('$imagePath/sample_map_image.png'), fit: BoxFit.cover))),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.05, 0.2], colors: [white, white.withOpacity(0)]))),
        Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                    color: white,
                    boxShadow: [BoxShadow(color: black.withOpacity(0.2), blurRadius: 24, offset: const Offset(0, 12))],
                    borderRadius: BorderRadius.circular(24)),
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.adjust, color: red_1),
                    const SizedBox(width: 14),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Pickup point', style: GoogleFonts.poppins(color: grey_2)),
                      Text('New Castle, Bachatle 3982', style: GoogleFonts.poppins(color: black, fontWeight: FontWeight.w600, fontSize: 16)),
                    ])
                  ]),
                  Divider(height: 40, color: grey_4),
                  Row(children: [
                    Icon(Icons.place, color: black),
                    const SizedBox(width: 14),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Pickup point', style: GoogleFonts.poppins(color: grey_2)),
                      Text('New Castle, Bachatle 3982', style: GoogleFonts.poppins(color: black, fontWeight: FontWeight.w600, fontSize: 16)),
                    ])
                  ]),
                  const SizedBox(height: 20),
                  PrimaryButton(
                      ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryConfirmScreen())), text: 'Continue')
                ])))
      ]));
}
