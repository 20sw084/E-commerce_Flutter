import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class SizeChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  const SizeChip(this.text, {this.isSelected = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(border: Border.all(color: isSelected ? black : grey_3, width: 2), borderRadius: BorderRadius.circular(25)),
      child: Text(text.toUpperCase(), style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: black)));
}
