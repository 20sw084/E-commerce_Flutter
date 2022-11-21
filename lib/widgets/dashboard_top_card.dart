import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import '../utils/constant_variables.dart';

class DashobardTopCard extends StatelessWidget {
  final String image, title;
  final VoidCallback onTap;
  final Color color;
  const DashobardTopCard({Key? key, required this.image, required this.title, required this.color, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
      child: GestureDetector(
          onTap: onTap,
          child: Container(
              height: 185,
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: color,
                  gradient: RadialGradient(
                      radius: 1, center: Alignment.bottomRight, stops: const [0, 0.85, 0.851], colors: [color, color.withOpacity(0.2), color]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.6), blurRadius: 25, spreadRadius: -10, offset: const Offset(0, 15)),
                    BoxShadow(color: color.withOpacity(0.4), blurRadius: 25, spreadRadius: -4, offset: const Offset(0, 15)),
                  ]),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title.replaceAll(' ', '\n'), style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: black, fontSize: 20, height: 1.2)),
                const SizedBox(height: 16),
                Padding(padding: const EdgeInsets.only(left: 4.0), child: Image.asset('$imagePath/$image', height: 80))
              ]))));
}
