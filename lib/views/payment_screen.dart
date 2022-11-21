import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/primary_button.dart';
import 'delivery_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      appBar: const CustomAppBar(title: 'Payment', isSearchVisible: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              PrimaryButton(ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryScreen())), text: 'Continue')),
      body: Column(children: [_buildPaymentCard('Paypal'), _buildPaymentCard('Google Pay'), _buildPaymentCard('Master Card')]));

  Container _buildPaymentCard(String text) => Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: white,
          border: Border.all(color: grey_5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: grey_3.withOpacity(0.75), blurRadius: 20, offset: const Offset(0, 12), spreadRadius: -8)]),
      child: Row(children: [
        Icon(EvaIcons.stopCircleOutline, color: red_1, size: 20),
        const SizedBox(width: 12),
        Text(text, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: black, fontSize: 18)),
        const Spacer(),
        Icon(EvaIcons.plusCircle, color: red_1, size: 28)
      ]));
}
