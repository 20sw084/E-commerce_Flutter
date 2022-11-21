import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  const PrimaryButton({Key? key, required this.ontap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: ontap,
      child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: red_1, borderRadius: BorderRadius.circular(40), boxShadow: [
            BoxShadow(color: red_1.withOpacity(0.2), blurRadius: 8, spreadRadius: -4, offset: const Offset(0, 8)),
            BoxShadow(color: red_1.withOpacity(0.2), blurRadius: 16, spreadRadius: -8, offset: const Offset(0, 12)),
          ]),
          child: Text(text, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: white, fontSize: 16))));
}
