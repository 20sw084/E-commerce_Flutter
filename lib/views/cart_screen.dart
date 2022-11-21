import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tri_karo_2/views/payment_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/primary_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: const CustomAppBar(title: 'Cart', isSearchVisible: false),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryButton(
                ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen())), text: 'Add to cart')),
        body: ListView.builder(
            itemCount: 12,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Row(children: [
                  Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(image: AssetImage('$imagePath/sample_product_photo.jpeg'), fit: BoxFit.cover))),
                  const SizedBox(width: 8),
                  Text('T-Shirt', style: GoogleFonts.poppins(fontSize: 20, color: black, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  CircleAvatar(radius: 16, backgroundColor: red_1.withOpacity(0.1), child: Icon(EvaIcons.minus, size: 18, color: red_1)),
                  const SizedBox(width: 20),
                  Text('0', style: GoogleFonts.poppins(fontSize: 18, color: black, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 20),
                  CircleAvatar(radius: 16, backgroundColor: red_1.withOpacity(0.1), child: Icon(EvaIcons.plus, size: 18, color: red_1)),
                ]))));
  }
}
