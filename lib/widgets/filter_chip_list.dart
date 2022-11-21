import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class FilterChipsList extends StatelessWidget {
  const FilterChipsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 40,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Chip(
                  backgroundColor: index == 0 ? red_1 : white,
                  side: BorderSide(color: index == 0 ? transparent : red_1),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  label: Text('data', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: index == 0 ? white : red_1, fontSize: 12))))));
}
