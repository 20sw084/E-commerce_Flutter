import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

  Padding menuCard(String text, IconData icon) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Row(children: [
        Icon(icon, color: red_1),
        const SizedBox(width: 16),
        Text(text, style: GoogleFonts.poppins(color: black, fontWeight: FontWeight.w500, fontSize: 16))
      ]));
