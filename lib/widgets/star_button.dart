import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class StarButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  const StarButton({this.isSelected = false, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color forgroundColor = isSelected ? white : red_1;
    Color backgroundColor = isSelected ? red_1 : white;
    Color borderColor = red_1;

    return Container(
        // height: 40,
        padding: const EdgeInsets.only(top: 6, bottom: 6, right: 14, left: 10),
        decoration:
            BoxDecoration(color: backgroundColor, border: Border.all(color: borderColor, width: 1.5), borderRadius: BorderRadius.circular(25)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(EvaIcons.star, color: forgroundColor, size: 12),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.poppins(color: forgroundColor, fontSize: 12, fontWeight: FontWeight.w500))
        ]));
  }
}
